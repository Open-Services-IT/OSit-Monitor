import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:osit_monitor/main_wrapper_controller.dart';
import 'package:osit_monitor/nfc_controller.dart';
import 'app_controller.dart';
import 'qr_data_page.dart';
import 'dialogs.dart';
import 'colors.dart';

class NfcScreen extends StatelessWidget {
  NfcScreen({super.key}) : super();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final MainWrapperController mainWrapperController =
      Get.put(MainWrapperController());
  final NfcController nfcController = Get.put(NfcController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      builder: (_) => Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              top: 5,
              right: 7,
              child: Image.asset(
                'assets/logo.png',
                scale: 7,
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: nfcController.startNFCReading,
                child: const Text('Escanear NFC'),
              ),
            ),
            // const DataPage(),
          ],
        ),
      ),
    );
  }
}
