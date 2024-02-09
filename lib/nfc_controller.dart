import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/record.dart';
import 'package:osit_monitor/app_controller.dart';

class NfcController extends GetxController {
  static NfcController get find => Get.find();
  // AppController appController = Get.put(AppController());
  void startNFCReading() async {
    try {
      NFCTag tag = await FlutterNfcKit.poll();
      if (tag.ndefAvailable ?? false) {
        List<NDEFRecord> ndefRecords = await FlutterNfcKit.readNDEFRecords();
        String ndefString = '';
        for (int i = 0; i < ndefRecords.length; i++) {
          ndefString += '${i + 1}: ${ndefRecords[i]}\n';
        }
        RegExp regExp = RegExp(r'text=([^ ]+)');
        Iterable<Match> matches = regExp.allMatches(ndefString);
        List<String?> extractedCharacters =
            matches.map((match) => match.group(1)).toList();
        String extractedCharactersString = extractedCharacters.join(', ');
        debugPrint(extractedCharactersString.trim());
        // appController.setQrCode(nfcCode: extractedCharactersString);
      }
    } catch (e) {
      debugPrint('Error reading NFC: $e');
    }
  }
}
