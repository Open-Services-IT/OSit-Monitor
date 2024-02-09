import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osit_monitor/nfc_controller.dart';
import 'qr_controller.dart';

import 'app_controller.dart';
import 'app_storage.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppStorage.init();

  Get
    ..put(QrController(), permanent: true)
    ..put(AppController(), permanent: true)
    ..put(NfcController(), permanent: true)
  ;

  runApp(const OSitMonitorApp());
}

class OSitMonitorApp extends StatelessWidget {
  const OSitMonitorApp({super.key});
  @override
  Widget build(BuildContext context) => GetBuilder<AppController>(
        builder: (_) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: _.theme,
          home: HomePage(),
        ),
      );
}
