import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/record.dart';
import 'package:osit_monitor/constants/strings.dart';
import 'package:osit_monitor/controllers/app_controller.dart';
import 'package:osit_monitor/helpers/utils.dart';

class NfcController extends GetxController {
  static NfcController get find => Get.find();
  AppController appController = Get.put(AppController());
  Map<String, String> nfcAvailabilityState = {
    "not_supported": "NFC no soportado",
    "disabled": "NFC esta deshabilitado",
    "available": "",
  };
  var retry = 0;
  final RxString _nfcStatus = ''.obs;
  set setNfcStatus(String value) => _nfcStatus.value = value;
  String get nfcStatus => _nfcStatus.value;
  Timer? timer;
  void getNfcAvailability() async {
    await FlutterNfcKit.nfcAvailability.then((value) {
      var nfcAvailabilityValue = value.toString();
      for (var state in nfcAvailabilityState.keys) {
        if (nfcAvailabilityValue.contains(state)) {
          setNfcStatus = nfcAvailabilityState[
              nfcAvailabilityValue.substring(16, nfcAvailabilityValue.length)]!;
        }
      }
    }).catchError((error) {
      // setNfcStatus = error.toString();
      AppUtils.showSnackBar("Ocurrio un error", SnackType.ERROR);
      AppUtils.printLog(error.toString());
    });
  }

  @override
  void dispose() {
    getNfcAvailability();
    timer?.cancel();
    super.dispose();
  }

  @override
  void onInit() async {
    super.onInit();
    getNfcAvailability();
    if (defaultTargetPlatform == TargetPlatform.android) {
      timer = Timer.periodic(const Duration(seconds: 2), (Timer t) {
        if (AppController().qrCode.isEmpty && !AppController().error) {
          startNFCReading();
        }
      });
    }
  }

  void startNFCReading() async {
    try {
      NFCTag tag = await FlutterNfcKit.poll();
      if (tag.ndefAvailable ?? false) {
        List<NDEFRecord> ndefRecords = await FlutterNfcKit.readNDEFRecords();
        String ndefString = '';
        for (int i = 0; i < ndefRecords.length; i++) {
          ndefString += '${i + 1}: ${ndefRecords[i]}';
        }
        RegExp regExp = RegExp(r'text=([^ ]+)');
        Iterable<Match> matches = regExp.allMatches(ndefString);
        List<String?> extractedCharacters =
        matches.map((match) => match.group(1)).toList();
        String extractedCharactersString = extractedCharacters.join(', ');
        AppUtils.printLog("NFC tag: $extractedCharactersString");
        FlutterNfcKit.finish().then((value) {
          // setLoading = true;
          appController
              .setNfcCode(extractedCharactersString)
              .then((res) => {AppUtils.printLog('readed ok')})
              .catchError((ex) => {AppUtils.printLog('readed with error')});
        }).catchError((error) {
          AppUtils.printLog(error.toString());
        });
      }
    } catch (e) {
      PlatformException error = e as PlatformException;
      if (error.message == 'Connection timed out') {
        AppUtils.printLog(error);
      }
    }
  }
}
