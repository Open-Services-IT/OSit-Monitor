import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:osit_monitor/controllers/app_controller.dart';
import 'package:osit_monitor/controllers/nfc_controller.dart';
import 'package:osit_monitor/controllers/qr_controller.dart';
import 'package:osit_monitor/screens/qr_screen.dart';
import 'package:osit_monitor/constants/colors.dart';
import 'package:osit_monitor/widgets/dialogs.dart';
import 'package:osit_monitor/controllers/main_wrapper_controller.dart';
import 'package:osit_monitor/screens/nfc_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final MainWrapperController mainWrapperController =
      Get.put(MainWrapperController());
  final NfcController nfcController = Get.put(NfcController());
  final QrController qrController = Get.put(QrController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: GestureDetector(
            onTap: _.resetQrCode,
            child: Text(
              _.qrCode,
              textScaler: TextScaler.linear(
                  MediaQuery.of(context).size.width < 375 ? .95 : 1.25),
              style: TextStyle(
                color: _.isDark ? Colors.white : Colors.black,
                decoration: TextDecoration.none,
                fontSize: 18,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          leading: Obx(
            () => GestureDetector(
              onTap: () {
                mainWrapperController
                    .goToTab(mainWrapperController.currentPage < 1 ? 1 : 0);
                _.resetQrCode();
              },
              child: Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width < 375 ? 2 : 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Icon(
                        mainWrapperController.currentPage < 1
                            ? Icons.nfc
                            : Icons.qr_code_2,
                        size: 32,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        mainWrapperController.title.value,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          leadingWidth: MediaQuery.of(context).size.width > 375 ? 82 : 70,
          actions: [
            Switch(
              activeColor: mainColor(context),
              value: _.isDark,
              onChanged: (val) {
                _.toggleTheme(dark: !_.isDark);
              },
            ),
            PopupMenuButton<int>(itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text("DB Params"),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text("User Preferences"),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem<int>(
                  value: 2,
                  child: Text("About ..."),
                ),
              ];
            }, onSelected: (value) {
              if (value == 0) {
                showDBConfig(context, _);
              } else if (value == 1) {
                showPreferences(context, _);
                _.preferencesUpdated();
              } else if (value == 2) {
                showAbout(context);
              }
            }),
          ],
        ),
        body: PageView(
          controller: mainWrapperController.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            QrScreen(),
            NfcScreen(),
          ],
        ),
      ),
    );
  }
}
