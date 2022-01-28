import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:external_path/external_path.dart';

class DownloadFileFirebaseStorage {
  static Future<void> downloadFileExample(
      String downloadUrl, String name) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();

    try {
      if (await _requestPermission(Permission.storage)) {
        File downloadToFile = File("/storage/emulated/0/Download/" + name);
        log(ExternalPath.DIRECTORY_DOWNLOADS);
        await FirebaseStorage.instance
            .refFromURL(downloadUrl)
            .writeToFile(downloadToFile);
        Get.showSnackbar(const GetSnackBar(
          duration: Duration(seconds: 2),
          message: 'File is downloaded',
        ));
      }
    } on FirebaseException catch (e) {
      Get.showSnackbar(GetSnackBar(
        duration: const Duration(seconds: 2),
        message: e.message,
      ));
    }
  }

  static Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        false;
      }
    }
    return false;
  }
}
