import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:osit_monitor/constants/strings.dart';

import '../constants/colors.dart';

class AppStorage extends GetxController {
  final box = GetStorage();

  static Future<void> init() async {
    await GetStorage.init();
  }

  // GUI
  bool get isDark => box.read('darkmode') ?? false;
  ThemeData get theme => isDark ? ThemeData.dark() : ThemeData.light();
  void toggleTheme(bool val) => box.write('darkmode', val);

  int get secsTimeout => box.read<int>('timeout') ?? 30;
  set secsTimeout(int val) => box.write('timeout', val);

  String get color =>
      box.read('color') ??
      "#$openServicesITColor"; //Colors.amber[900]!.toHex();

  set color(String val) {
    var val1 = val.replaceFirst('#', '');
    int a = int.tryParse(val1, radix: 16) ?? 0;
    box.write('color', a > 0 ? val : "#$openServicesITColor");
  }

  double initialScale = 0.75;
  String get size => box.read('size') ?? initialScale.toString();

  set size(String value) {
    box.write('size', value.toString());
  }
  // DB
  String get host => box.read('host') ?? StringValues.initialDbParams.host;
  set host(String val) => box.write('host', val);

  int get port => box.read<int>('port') ?? StringValues.initialDbParams.port;
  set port(int val) => box.write('port', val);

  String get user => box.read('user') ?? StringValues.initialDbParams.username;
  set user(String val) => box.write('user', val);

  String get password =>
      box.read('password') ?? StringValues.initialDbParams.pass;
  set password(String val) => box.write('password', val);

  String get database =>
      box.read('database') ?? StringValues.initialDbParams.db;
  set database(String val) => box.write('database', val);

  // Package Info data
  String get appName => box.read('appName') ?? StringValues.appName;
  set appName(String val) => box.write('appName', val);
  String get appVersion => box.read('appVersion') ?? '0.0.1';
  set appVersion(String val) => box.write('appVersion', val);
  String get buildVersion => box.read('buildVersion') ?? '1';
  set buildVersion(String val) => box.write('buildVersion', val);
  String get appCopyright => box.read('appCopyright');
  set appCopyright(String val) => box.write('appCopyright', val);
}
