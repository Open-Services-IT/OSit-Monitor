import 'package:flutter/foundation.dart';
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
        body: Obx(
          () => Stack(
            children: [
              if ((nfcController.nfcStatus !=
                  nfcController.nfcAvailabilityState['available']))
                Center(
                  child: Text(
                    nfcController.nfcStatus,
                    textScaler: TextScaler.linear(
                      MediaQuery.of(context).size.width > 500
                          ? 2.5
                          : (MediaQuery.of(context).size.width / 4) < 90
                              ? .8
                              : 1.3,
                    ),
                    style: TextStyle(
                      color: _.isDark ? Colors.white : Colors.black,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              Positioned(
                bottom: 10,
                right: 7,
                child: Image.asset(
                  'assets/splash_screen/OSLogo.png',
                  width: MediaQuery.of(context).size.width / 3.75,
                ),
              ),
              const DataPage(),
              if (_.map.isEmpty && defaultTargetPlatform == TargetPlatform.iOS)
                Positioned(
                  top: 10,
                  left: 10,
                  child: ElevatedButton(
                    onPressed: nfcController.startNFCReading,
                    child: const Text('Escanear NFC'),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
