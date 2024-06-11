import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:osit_monitor/controllers/app_controller.dart';
import 'package:osit_monitor/firebase_options.dart';
import 'package:osit_monitor/helpers/utils.dart';
import 'package:osit_monitor/screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AppUtils.initServices();
  runApp(const OSitMonitorApp());
}

class OSitMonitorApp extends StatelessWidget {
  const OSitMonitorApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392, 744),
      builder: (context, child) => GetBuilder<AppController>(
        builder: (_) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: _.theme,
          home: HomePage(),
        ),
      ),
    );
  }
}
