import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osit_monitor/controllers/app_controller.dart';
import 'package:osit_monitor/helpers/utils.dart';
import 'package:tuple/tuple.dart';
import 'package:url_launcher/url_launcher.dart';

class DataPage extends StatelessWidget {
  const DataPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      builder: (_) => FutureBuilder(
        future: _.readData(),
        builder: (context,
            AsyncSnapshot<Map<String, Tuple2<String, String>>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text("there is no connection");
            case ConnectionState.active:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.data != null) {
                Map<String, Tuple2<String, String>>? myMap =
                    snapshot.data; // transform your snapshot data in map
                var keysList = myMap?.keys
                    .toList(); // getting all keys of your map into a list
                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ), //.all(20.0),
                  child: _.loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          //itemExtent: 90,
                          shrinkWrap: true,
                          itemCount: keysList?.length,
                          itemBuilder: (BuildContext context, int index) {
                            var key = keysList![index];
                            var code = myMap![keysList[index]]!.item1;
                            var color =
                                int.parse(myMap[keysList[index]]!.item2);
                            var url =
                                Uri.tryParse(code)?.host.isNotEmpty ?? false;
                            return ListTile(
                              title: _buildTitle(
                                key,
                                color,
                              ),
                              subtitle: _buildValue(
                                code,
                                url,
                                color,
                              ),
                              visualDensity: VisualDensity.compact,
                              dense: true,
                            );
                          },
                        ),
                );
              }
              // here your snapshot data is null so SharedPreferences has no data...
              return const Text("No data");
          } //end switch
        },
      ),
    );
  }

  Widget _buildTitle(String key, int state) {
    TextStyle? textStyle;
    switch (state) {
      case 1:
        textStyle = const TextStyle(color: Colors.amber, fontSize: 18);
        break;
      case 2:
        textStyle = const TextStyle(color: Colors.red, fontSize: 18);
        break;
      case 3:
        textStyle = const TextStyle(color: Colors.blue, fontSize: 18);
        break;
      case 4:
        textStyle =
            const TextStyle(color: Colors.deepPurpleAccent, fontSize: 18);
        break;
      default:
        textStyle = const TextStyle(fontSize: 18);
    }
    String scale = AppController().store.size;

    return Transform.translate(
      offset: const Offset(0, 0),
      child: Text(
        key,
        textScaler: TextScaler.linear(double.parse(scale)),
        //maxLines: 1,
        softWrap: true,
        overflow: TextOverflow.visible,
        style: textStyle.merge(
          const TextStyle(fontWeight: FontWeight.bold),
        ),
        textAlign: AppUtils.showCentered(word: key) ? TextAlign.center : null,
      ),
    );
  }
}

Widget _buildValue(String code, bool url, int color) {
  String scale = AppController().store.size;
  if (url) {
    return UrlButton(code, 1);
  } else {
    return Text(
      code,
      style: const TextStyle(fontSize: 15),
      textScaler: TextScaler.linear(double.parse(scale)),
      textAlign: color == 2 ? TextAlign.center : null,
    );
  }
}

class UrlButton extends LinkButton {
  String code;
  double scale;

  UrlButton(
    this.code,
    this.scale, {
    Key? key,
  }) : super(code, code, scale, key: key);

  @override
  Widget build(BuildContext context) => LinkButton(code, code, scale);
}

class LinkButton extends StatelessWidget {
  String text;
  String uri;
  double scale;

  LinkButton(
    this.text,
    this.uri,
    this.scale, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(50, 15),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          alignment: Alignment.topLeft),
      onPressed: () async {
        final Uri toLaunch = Uri.parse(uri);
        if (!await launchUrl(toLaunch, mode: LaunchMode.externalApplication)) {
          throw Exception('Could not launch $uri');
        }
      },
      child: Text(
        text,
        textScaleFactor: scale,
        //maxLines: 2,
        //softWrap: true,
        overflow: TextOverflow.visible,
        style: TextStyle(
            decorationColor: Colors.blue[200],
            decoration: TextDecoration.underline),
      ),
    );
  }
}
