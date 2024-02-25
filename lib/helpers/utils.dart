import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:osit_monitor/constants/colors.dart';
import 'package:osit_monitor/constants/dimens.dart';
import 'package:osit_monitor/constants/strings.dart';
import 'package:osit_monitor/controllers/app_controller.dart';
import 'package:osit_monitor/controllers/main_wrapper_controller.dart';
import 'package:osit_monitor/controllers/nfc_controller.dart';
import 'package:osit_monitor/controllers/qr_controller.dart';
import 'package:osit_monitor/services/app_storage.dart';
import 'package:package_info/package_info.dart';

abstract class AppUtils {
  static void showLoadingDialog() {
    closeDialog();
    Get.dialog<void>(
      WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: CupertinoTheme(
              data: CupertinoTheme.of(Get.context!).copyWith(
                brightness: Brightness.dark,
                primaryColor: Colors.white,
              ),
              child: const CircularProgressIndicator(),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void showError(String message) {
    closeSnackBar();
    closeDialog();
    closeBottomSheet();
    if (message.isEmpty) return;
    Get.rawSnackbar(
      messageText: Text(
        message,
      ),
      mainButton: TextButton(
        onPressed: () {
          if (Get.isSnackbarOpen) {
            Get.back<void>();
          }
        },
        child: const Text(
          StringValues.okay,
        ),
      ),
      backgroundColor: const Color(0xFF503E9D),
      margin: Dimens.edgeInsets16,
      borderRadius: Dimens.fifteen,
      snackStyle: SnackStyle.FLOATING,
    );
  }

  static void showBottomSheet({
    required List<Widget> children,
    double? borderRadius,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    bool? isScrollControlled,
  }) {
    closeBottomSheet();
    Get.bottomSheet(
      Padding(
        padding: Dimens.edgeInsets8_0,
        child: Column(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius ?? Dimens.zero),
          topRight: Radius.circular(borderRadius ?? Dimens.zero),
        ),
      ),
      isScrollControlled: isScrollControlled ?? false,
      barrierColor: ColorValues.blackColor.withOpacity(0.5),
      backgroundColor:
          Theme.of(Get.context!).bottomSheetTheme.modalBackgroundColor,
    );
  }

  static void showOverlay(Function func) {
    Get.showOverlay(
      loadingWidget: const CupertinoActivityIndicator(),
      opacityColor: Theme.of(Get.context!).bottomSheetTheme.backgroundColor!,
      opacity: 0.5,
      asyncFunction: () async {
        await func();
      },
    );
  }

  static void showSnackBar(String message, SnackType type, {int? duration}) {
    closeSnackBar();
    Get.showSnackbar(
      GetSnackBar(
        margin: EdgeInsets.only(
          left: Dimens.sixTeen,
          right: Dimens.sixTeen,
          bottom: Dimens.thirtyTwo,
        ),
        borderRadius: Dimens.four,
        padding: Dimens.edgeInsets16,
        snackStyle: SnackStyle.FLOATING,
        messageText: Text(
          message,
          style: TextStyle(
            color: Theme.of(Get.context!).scaffoldBackgroundColor,
          ),
        ),
        icon: Icon(
          type == SnackType.ERROR
              ? CupertinoIcons.clear_circled_solid
              : type == SnackType.SUCCESS
                  ? CupertinoIcons.check_mark_circled_solid
                  : CupertinoIcons.info_circle_fill,
          color: type == SnackType.ERROR
              ? ColorValues.errorColor
              : type == SnackType.SUCCESS
                  ? ColorValues.successColor
                  : type == SnackType.WARNING
                      ? ColorValues.warningColor
                      : Theme.of(Get.context!).iconTheme.color,
        ),
        shouldIconPulse: false,
        backgroundColor: Theme.of(Get.context!).snackBarTheme.backgroundColor!,
        duration: Duration(seconds: duration ?? 2),
      ),
    );
  }

  /// Close any open snack bar.
  static void closeSnackBar() {
    if (Get.isSnackbarOpen) Get.back<void>();
  }

  /// Close any open dialog.
  static void closeDialog() {
    if (Get.isDialogOpen ?? false) Get.back<void>();
  }

  /// Close any open bottom sheet.
  static void closeBottomSheet() {
    if (Get.isBottomSheetOpen ?? false) Get.back<void>();
  }

  static void closeFocus() {
    if (FocusManager.instance.primaryFocus!.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  static void printLog(message) {
    debugPrint(
        "***********************************************************************");
    debugPrint(message.toString(), wrapWidth: 1024);
    debugPrint(
        "***********************************************************************");
  }

  static ThemeMode handleAppTheme(mode) {
    if (mode == StringValues.dark) {
      return ThemeMode.dark;
    }
    if (mode == StringValues.light) {
      return ThemeMode.light;
    }
    return ThemeMode.system;
  }

  static void getVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      AppStorage().appName = packageInfo.appName;
      AppStorage().appVersion = packageInfo.version;
      AppStorage().appCopyright = StringValues.legalese;
    } catch (ex) {
      AppUtils.printLog(ex);
      throw Exception(ex);
    }
  }

  static Future<void> initServices() async {
    await GetStorage.init();
    Get
      ..put(QrController(), permanent: true)
      ..put(AppController(), permanent: true)
      ..put(MainWrapperController(), permanent: true)
      ..put(NfcController(), permanent: true);
    getVersion();
  }

  static bool isAllCapitalizedWithSecondColon({required String word}) {
    // Check if the word is the same as its uppercase version
    // and if the second letter is ":"
    return word == word.toUpperCase() && word.length >= 2 && word[1] != ':';
  }
}

extension DateTimeFromTimeOfDay on DateTime {
  DateTime appliedFromTimeOfDay(TimeOfDay timeOfDay) {
    return DateTime.utc(year, month, day, timeOfDay.hour, timeOfDay.minute);
  }
}

DateTime today = DateTime.now()
    .appliedFromTimeOfDay(const TimeOfDay(hour: 0, minute: 0))
    .add(
      const Duration(
        days: 1,
      ),
    );
