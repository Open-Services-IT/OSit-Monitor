import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:osit_monitor/constants/dimens.dart';
import 'package:osit_monitor/widgets/bottom_bar_item.dart';
import 'package:osit_monitor/constants/colors.dart';
import 'package:osit_monitor/widgets/dialogs.dart';
import 'package:osit_monitor/controllers/main_wrapper_controller.dart';
import 'package:osit_monitor/screens/nfc_screen.dart';

import '../controllers/app_controller.dart';
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
            title: GestureDetector(
              onTap: _.resetQrCode,
              child: Text(
                _.qrCode,
                textScaler: TextScaler.linear(
                    (MediaQuery.of(context).size.width / 4) < 90 ? .8 : 1.25),
                style: TextStyle(
                  color: _.isDark ? Colors.white : Colors.black,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
            ),
            // titleSpacing: 0,
            leading: Obx(
              () => Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {
                            mainWrapperController.goToTab(
                                mainWrapperController.currentPage < 1 ? 1 : 0);
                            _.resetQrCode();
                          },
                          icon: Icon(mainWrapperController.currentPage < 1
                              ? Icons.nfc
                              : Icons.qr_code_2),
                          iconSize: 32,
                        )),
                    Expanded(
                      flex: 1,
                      child: Text(mainWrapperController.title.value),
                    ),
                  ],
                ),
              ),
            ),
            leadingWidth: MediaQuery.of(context).size.width / 4,
            actions: [
              Switch(
                activeColor: mainColor(context),
                value: _.isDark,
                onChanged: (val) {
                  _.toggleTheme(dark: !_.isDark);
                },
              ),
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
        // TODO move to /widgets
        // bottomNavigationBar: BottomAppBar(
        //   padding: const EdgeInsets.symmetric(horizontal: 15),
        //   elevation: 0,
        //   notchMargin: 10,
        //   height: 60,
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisSize: MainAxisSize.max,
        //     children: [
        //       Expanded(
        //         flex: 12,
        //         child: CustomBottomBarItem(
        //           icon: Icons.qr_code,
        //           text: 'QR',
        //           onCustomTap: () => mainWrapperController.goToTab(0),
        //         ),
        //       ),
        //       Container(
        //         width: 1,
        //         margin: const EdgeInsets.symmetric(vertical: 10),
        //         color: Colors.purple,
        //       ),
        //       Expanded(
        //         flex: 12,
        //         child: CustomBottomBarItem(
        //           icon: Icons.nfc,
        //           text: 'NFC',
        //           onCustomTap: () => mainWrapperController.goToTab(1),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
