import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osit_monitor/controllers/nfc_controller.dart';
import '../controllers/app_controller.dart';
import 'qr_data_page.dart';

class NfcScreen extends StatelessWidget {
  NfcScreen({super.key}) : super();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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
              bottom: 10,
              right: 7,
              child: Image.asset(
                'assets/logo.png',
                scale: 7,
              ),
            ),
            const DataPage(),
            if (_.map.isEmpty)
              Positioned(
                top: 10,
                left: 10,
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
