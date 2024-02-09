import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:osit_monitor/bottom_bar_item.dart';
import 'package:osit_monitor/colors.dart';
import 'package:osit_monitor/dialogs.dart';
import 'package:osit_monitor/main_wrapper_controller.dart';
import 'package:osit_monitor/nfc_screen.dart';

import 'app_controller.dart';
import 'qr_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final MainWrapperController mainWrapperController =
      Get.put(MainWrapperController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
            title: TextButton(
              onPressed: () {
                _.resetQrCode();
              },
              child: Obx(
                () => Text(
                  "${mainWrapperController.title}",
                  textScaleFactor: 1.4,
                  style: TextStyle(
                    color: _.isDark ? Colors.white : Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
            ),
            actions: [
              Switch(
                  activeColor: mainColor(context),
                  value: _.isDark,
                  onChanged: (val) {
                    _.toggleTheme(dark: !_.isDark);
                  }),
              PopupMenuButton<int>(
                  // add icon, by default "3 dot" icon
                  // icon: Icon(Icons.book)
                  itemBuilder: (context) {
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
            ]),
        body: PageView(
          controller: mainWrapperController.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            QrScreen(),
            NfcScreen(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          elevation: 0,
          notchMargin: 10,
          height: 60,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 12,
                child: CustomBottomBarItem(
                  icon: Icons.qr_code,
                  text: 'QR',
                  onCustomTap: () => mainWrapperController.goToTab(0),
                ),
              ),
              Container(
                width: 1,
                margin: const EdgeInsets.symmetric(vertical: 10),
                color: Colors.purple,
              ),
              Expanded(
                flex: 12,
                child: CustomBottomBarItem(
                  icon: Icons.nfc,
                  text: 'NFC',
                  onCustomTap: () => mainWrapperController.goToTab(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
