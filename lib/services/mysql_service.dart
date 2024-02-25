import 'dart:developer';

import 'package:mysql_client/mysql_client.dart';
import 'package:tuple/tuple.dart';

import 'app_storage.dart';

class Mysql {
  final store = AppStorage();

  Future<MySQLConnection> getConnection() async {
    try {
      final conn = await MySQLConnection.createConnection(
        host: store.host,
        port: store.port,
        userName: store.user,
        password: store.password,
        databaseName: store.database,
        secure: false,
      );
      await conn.connect();
      return conn;
    } catch (ex) {
      // AppUtils.printLog("getConnection $ex");
      rethrow;
    }
  }

  Future<Map<String, Tuple2<String, String>>> readQRData(String qrCode) async {
    Map<String, Tuple2<String, String>> map = {};
    try {
      MySQLConnection conn = await getConnection();
      if (conn.connected) {
        IResultSet result = await conn.execute("""select 
      services.description, 
      services.output,
      services.last_hard_state,
      hosts.address
      FROM services, hosts 
      WHERE services.host_id = hosts.host_id 
      AND (from_unixtime(services.last_check) >= NOW() - INTERVAL 1 WEEK) 
      AND hosts.name = :qrcode
      ORDER BY services.description ASC, 
      services.last_check DESC""", {"qrcode": qrCode});

        for (final row in result.rows) {
          map['Dirección IP'] = Tuple2('${row.colAt(3)}', "0");
          map['${row.colAt(0)}'] = Tuple2('${row.colAt(1)}', '${row.colAt(2)}');
        }
        conn.close();
      }
    } catch (e) {
      rethrow;
    }

    return Future(() {
      return map;
    });
  }
}
