import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/app_controller.dart';

const openServicesITColor = "6A0A57";
mainColor(BuildContext context) => HexColor.fromHex(
    Get.find<AppController>().store.color); //Colors.amber[900];
//mainColor(context) => Theme.of(context).primaryColorDark;

overlayColor(BuildContext context) =>
    Theme.of(context).canvasColor.withAlpha(200);
// overlayColor: ctrl.isDark
//     ? Colors.white70
//     : Colors.black87,

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.tryParse(buffer.toString(), radix: 16) ??
        int.parse(openServicesITColor, radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}'
      '${alpha.toRadixString(16).padLeft(2, '0')}';
}


abstract class ColorValues {
  static const Color darkBgColor = Color.fromARGB(255, 20, 20, 29);
  static const Color darkBodyTextColor = Color.fromARGB(255, 240, 240, 240);
  static const Color darkChatBubbleColor = Color.fromARGB(255, 18, 66, 148);
  static const Color darkDialogColor = Color.fromARGB(255, 36, 36, 56);
  static const Color darkDividerColor = Color.fromARGB(255, 70, 70, 70);
  static const Color darkGrayColor = Color.fromARGB(255, 120, 120, 120);
  static const Color darkTitleSmallTextColor =
  Color.fromARGB(255, 100, 100, 100);
  static const Color darkSubtitleTextColor = Color.fromARGB(255, 160, 160, 160);

  static const Color darkerGrayColor = Color.fromARGB(255, 80, 80, 80);
  static const Color grayColor = Color.fromARGB(255, 180, 180, 180);

  static const Color lightBgColor = Color.fromRGBO(250, 250, 250, 1);
  static const Color lightDialogColor = Color.fromRGBO(252, 252, 252, 1);
  static const Color lightBodyTextColor = Color.fromARGB(255, 30, 30, 30);
  static const Color lightChatBubbleColor = Color.fromARGB(255, 242, 242, 242);
  static const Color lightDividerColor = Color.fromARGB(255, 200, 200, 200);
  static const Color lightGrayColor = Color.fromARGB(255, 210, 210, 210);
  static const Color lightTitleSmallTextColor =
  Color.fromARGB(255, 140, 140, 140);
  static const Color lightSubtitleTextColor =
  Color.fromARGB(255, 100, 100, 100);

  static const Color linkColor = Color.fromARGB(255, 56, 130, 240);

  static const Color primaryColor10 = Color.fromRGBO(240, 90, 100, .1);
  static const Color primaryColor20 = Color.fromRGBO(240, 90, 100, .2);
  static const Color primaryColor30 = Color.fromRGBO(240, 90, 100, .3);
  static const Color primaryColor40 = Color.fromRGBO(240, 90, 100, .4);
  static const Color primaryColor50 = Color.fromRGBO(240, 90, 100, .5);
  static const Color primaryColor60 = Color.fromRGBO(240, 90, 100, .6);
  static const Color primaryColor70 = Color.fromRGBO(240, 90, 100, .7);
  static const Color primaryColor80 = Color.fromRGBO(240, 90, 100, .8);
  static const Color primaryColor90 = Color.fromRGBO(240, 90, 100, .9);
  static const Color primaryColor = Color.fromRGBO(240, 90, 100, 1);

  static const Color primaryLightColor = Color.fromARGB(200, 240, 90, 100);

  static const Color successColor = Color.fromARGB(255, 76, 175, 80);
  static const Color errorColor = Color.fromARGB(255, 244, 67, 54);
  static const Color warningColor = Color.fromARGB(255, 240, 156, 0);

  static const Color transparent = Color.fromARGB(0, 0, 0, 0);
  static const Color shadowColor = Color.fromARGB(255, 0, 0, 0);

  static const Color blackColor10 = Color.fromRGBO(0, 0, 0, .1);
  static const Color blackColor20 = Color.fromRGBO(0, 0, 0, .2);
  static const Color blackColor30 = Color.fromRGBO(0, 0, 0, .3);
  static const Color blackColor40 = Color.fromRGBO(0, 0, 0, .4);
  static const Color blackColor50 = Color.fromRGBO(0, 0, 0, .5);
  static const Color blackColor60 = Color.fromRGBO(0, 0, 0, .6);
  static const Color blackColor70 = Color.fromRGBO(0, 0, 0, .7);
  static const Color blackColor80 = Color.fromRGBO(0, 0, 0, .8);
  static const Color blackColor90 = Color.fromRGBO(0, 0, 0, .9);
  static const Color blackColor = Color.fromRGBO(0, 0, 0, 1);

  static const Color whiteColor = Color.fromRGBO(255, 255, 255, 1);
  static const Color whiteColor10 = Color.fromRGBO(255, 255, 255, .1);
  static const Color whiteColor20 = Color.fromRGBO(255, 255, 255, .2);
  static const Color whiteColor30 = Color.fromRGBO(255, 255, 255, .3);
  static const Color whiteColor40 = Color.fromRGBO(255, 255, 255, .4);
  static const Color whiteColor50 = Color.fromRGBO(255, 255, 255, .5);
  static const Color whiteColor60 = Color.fromRGBO(255, 255, 255, .6);
  static const Color whiteColor70 = Color.fromRGBO(255, 255, 255, .7);
  static const Color whiteColor80 = Color.fromRGBO(255, 255, 255, .8);
  static const Color whiteColor90 = Color.fromRGBO(255, 255, 255, .9);

  static const Color kiomOrange = Color(0xFFFA9A46);
  static const Color kiomGolden = Color(0xFFD6BD3E);
  static const Color kiomFucsia = Color(0xFFF033EA);
  static const Color kiomViolet = Color(0xFF5045D6);
  static const Color kiomLightViolet = Color(0xFFD7B5FF);
  static const Color kiomBlueSky = Color(0xFF33B9FA);
  static const Color kiomBlueOne = Color(0xFF5271FF);
  static const Color kiomSalmon = Color(0xFFFA8072);
  // Canvas colors
  static const Color kiomBlueSkyLight = Color(0xFF87fbff);
  static const Color kiomPink = Color(0xFFFAABE5);
  static const Color kiomShadowPink = Color(0xFFF8B1F0);
  static const Color kiomLightPink = Color(0xFFF5CEC7);
  static const Color kiomLighterPink = Color(0xFFfee7fc);
  static const Color kiomDarkPink = Color(0xFFFF66C4);
  static const Color kiomSoftGold = Color(0xFFF1E098);
  static const Color kiomSoftGreen = Color(0xFFA1FEDB);
  static const Color kiomSoftSkyBlue = Color(0xFFAED5E5);
  static const Color kiomSoftOrange = Color(0xFFF6CEA9);
  static const Color kiomLightGreen = Color(0xFFCFEDCD);
  static const Color kiomRed = Color(0xFFFF3752);


  static const Color kiomGreen = Color(0xFF37A691);
  static const Color kiomLightGray = Color(0xFFF2F2F2);
  static const Color kiomGreenBlue = Color(0xFF0388A6);
  static const Color kiomBlue = Color(0xFF0378A6);
  static const Color kiomBlack = Color(0xFF0D0D0D);




  static const Color inputFillColor = kiomSalmon;
  static const Color inputBorderColor = kiomGolden;
  static const Color inputFontColor = whiteColor;

  static Gradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: const [0.3, 0.7, 0.9, 1],
    colors: [
      kiomSalmon.withOpacity(.75),
      kiomSalmon.withOpacity(.65),
      kiomSalmon.withOpacity(.55),
      kiomSalmon.withOpacity(.45),
    ],
  );
  static BoxDecoration backgroundDecoration =
  BoxDecoration(gradient: backgroundGradient);
}