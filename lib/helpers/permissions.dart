import 'package:osit_monitor/helpers/utils.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class AppPermissions {
  static Future<bool> checkStoragePermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      if (await Permission.storage.request().isGranted) {
        return true;
      }
      return false;
    }
    if (status.isRestricted) {
      AppUtils.showError("Storage Permission Error");
      return false;
    }
    if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }

    return true;
  }

  static Future<bool> checkCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      if (await Permission.camera.request().isGranted) {
        return true;
      }
      return false;
    }
    if (status.isRestricted) {
      AppUtils.showError('Camera Permission Error');
      return false;
    }
    if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }
    return true;
  }
}
