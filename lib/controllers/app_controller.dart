import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:tuple/tuple.dart';

import '../services/app_storage.dart';
import '../services/mysql_service.dart';
import 'qr_controller.dart';

class AppController extends GetxController {
  static AppController get find => Get.find();
  QrController qrController = Get.put(QrController());
  final store = AppStorage();
  final mysql = Mysql();

  // GUI
  bool get isDark => store.isDark;
  ThemeData get theme => isDark ? ThemeData.dark() : ThemeData.light();
  void toggleTheme({bool dark = false}) {
    store.toggleTheme(dark);
    update();
  }

  //QR
  String qrCode = "";
  Barcode? scanData;

  setNfcCode(String nfcCode) async  {
    try {
      qrCode = nfcCode;
      map = await mysql.readQRData(nfcCode);
      update();
      if (store.msTimeout > 0) {
        Future.delayed(
            Duration(milliseconds: store.msTimeout), () => resetQrCode());
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  setQrCode(Barcode val) async {
    if (val.code == scanData?.code) return;
    scanData = val;
    var format = describeEnum(scanData!.format);
    var code = '${scanData!.code}';
    log('Barcode Type: $format   Data: $code');

    map.clear();

    // Test formatos conocidos
    if (Uri.tryParse(code)?.host.isNotEmpty ?? false) {
      // URL
      qrCode = "URI";
      map["Click to go"] = Tuple2(code, "0");
      //} else if (code.contains('mail')) { // Lo dejo aquí, mail, card, etc...
    } else {
      // VAMOS A LA BD
      qrCode = code;
      map = await mysql.readQRData(code);
      if (map.isEmpty) {
        // FORMATOS QUE NO MANEJAMOS
        qrCode = format.toUpperCase();
        map[code] = Tuple2(format, "0");
      }
    }

    update();
    if (store.msTimeout > 0) {
      Future.delayed(
          Duration(milliseconds: store.msTimeout), () => resetQrCode());
    }
  }

  resetQrCode() {
    qrCode = "";
    scanData = null;
    map = {};
    update();
  }

  preferencesUpdated() {
    update();
  }

  bool get isPaused => paused;
  CameraFacing facingFront = CameraFacing.front;

  Future<CameraFacing>? getCameraInfo() =>
      qrController.controller?.getCameraInfo();

  Future<bool?>? getFlashStatus() => qrController.controller?.getFlashStatus();

  void toggleCamera() async {
    await qrController.controller?.flipCamera();
    update();
  }

  void toggleFlash() async {
    await qrController.controller?.toggleFlash();
    update();
  }

  bool paused = false;
  void toggleAction() {
    paused = !paused;
    if (paused) {
      qrController.controller?.pauseCamera();
    } else {
      qrController.controller?.resumeCamera();
    }
    update();
  }

  //BD
  Map<String, Tuple2<String, String>> map = {};

  Future<Map<String, Tuple2<String, String>>> readData() {
    return Future(() {
      return map;
    });
  }
}
