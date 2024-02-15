import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osit_monitor/controllers/app_controller.dart';
import 'package:osit_monitor/controllers/main_wrapper_controller.dart';
import 'package:osit_monitor/controllers/nfc_controller.dart';
import 'package:osit_monitor/controllers/qr_controller.dart';
import 'package:osit_monitor/screens/home_page.dart';
import 'package:osit_monitor/services/app_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppStorage.init();

  Get
    ..put(QrController(), permanent: true)
    ..put(AppController(), permanent: true)
    ..put(MainWrapperController(), permanent: true)
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
