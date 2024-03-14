import 'package:flutter/material.dart';
import 'package:osit_monitor/constants/dimens.dart';
import 'package:osit_monitor/constants/strings.dart';
import 'package:tuple/tuple.dart';
import '../controllers/app_controller.dart';
import '../constants/colors.dart';

dialogTextStyle(BuildContext context) => const TextStyle(fontSize: 24.0);
elevatedButtonStyle(BuildContext context) =>
    ElevatedButton.styleFrom(backgroundColor: mainColor(context));
elevatedButtonCancel(context) =>
    ElevatedButton.styleFrom(backgroundColor: Colors.white);
elevatedButtonCancelText(BuildContext context) =>
    const TextStyle(color: Colors.black);

showAbout(BuildContext context) {
  showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/icon.png',
                      width: Dimens.screenWidth / 8,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  AppController().store.appName,
                                  style: const TextStyle(),
                                  textScaler: TextScaler.linear(
                                    AppController().store.initialScale *
                                                MediaQuery.of(context)
                                                    .size
                                                    .width >
                                            375
                                        ? 2
                                        : 1.2,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  AppController().store.appVersion,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 22,
                                  ),
                                  textScaler: TextScaler.linear(
                                    Dimens.screenWidth > 375
                                        ? AppController().store.initialScale *
                                            1.2
                                        : AppController().store.initialScale *
                                            .85,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  StringValues.legalese,
                                  style: const TextStyle(
                                    fontSize: 22,
                                  ),
                                  textScaler: TextScaler.linear(
                                    Dimens.screenWidth > 375
                                        ? AppController().store.initialScale *
                                            1.5
                                        : AppController().store.initialScale *
                                            .85,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: AppController().launchOSITUrl,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/splash_screen/OSLogo.png',
                      fit: BoxFit.contain,
                      width: Dimens.screenWidth < 375
                          ? Dimens.screenWidth / 2
                          : Dimens.screenWidth / 3,
                      // color: const Color.fromARGB(222, 255, 255, 255),
                      // colorBlendMode: BlendMode.dstOut,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

showPreferences(
  BuildContext context,
  AppController ctrl,
) {
  var entries = <Tuple3<String, Function, TextEditingController>>[
    Tuple3(
      'Timeout (s)',
      (val) => ctrl.store.secsTimeout = int.tryParse(val.text) ?? 30,
      TextEditingController(
        text: ctrl.store.secsTimeout.toString(),
      ),
    ),
    Tuple3('Color', (val) => ctrl.store.color = val.text.trim(),
        TextEditingController(text: ctrl.store.color)),
    Tuple3('Size', (val) => ctrl.store.size = val.text.trim(),
        TextEditingController(text: ctrl.store.size.toString())),
  ];

  showDataConfig(context, "User Preferences", entries);
}

showDBConfig(
  BuildContext context,
  AppController ctrl,
) {
  var entries = <Tuple3<String, Function, TextEditingController>>[
    Tuple3('Host', (val) => ctrl.store.host = val.text.trim(),
        TextEditingController(text: ctrl.store.host)),
    Tuple3('Port', (val) => ctrl.store.port = int.tryParse(val.text) ?? 3306,
        TextEditingController(text: ctrl.store.port.toString())),
    Tuple3('Username', (val) => ctrl.store.user = val.text.trim(),
        TextEditingController(text: ctrl.store.user)),
    Tuple3('Password', (val) => ctrl.store.password = val.text.trim(),
        TextEditingController(text: ctrl.store.password)),
    Tuple3('Database', (val) => ctrl.store.database = val.text.trim(),
        TextEditingController(text: ctrl.store.database)),
  ];

  showDataConfig(context, "MySQL settings", entries);
}

showDataConfig(
  BuildContext context,
  //AppController ctrl,
  String title,
  List<Tuple3<String, Function, TextEditingController>> entries,
) {
  var colorAux = Colors.grey.shade500;
  const radio = Radius.circular(15.0);
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(radio),
          ),
          contentPadding: const EdgeInsets.only(top: 5.0),
          title: Text(
            title,
            style: dialogTextStyle(context),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Divider(color: colorAux),
                for (var i = 0; i < entries.length; i++) ...[
                  ListTile(
                    title: TextField(
                      controller: entries[i].item3,
                      textAlignVertical: TextAlignVertical.bottom,
                      style: dialogTextStyle(context),
                    ),
                    subtitle: Text(entries[i].item1),
                    visualDensity: VisualDensity.compact,
                    dense: true,
                    minVerticalPadding: 0,
                  ),
                ],
                const SizedBox(height: 15.0),
                Container(
                    decoration: BoxDecoration(
                      color: colorAux,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: radio, bottomRight: radio),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: elevatedButtonCancel(context),
                              child: Text(
                                "Cancel",
                                style: elevatedButtonCancelText(context),
                              )),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              for (var i = 0; i < entries.length; i++) {
                                entries[i].item2(entries[i].item3.value);
                              }
                              Navigator.of(context).pop();
                            },
                            style: elevatedButtonStyle(context),
                            child: const Text("Confirm"),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        );
      });
}
