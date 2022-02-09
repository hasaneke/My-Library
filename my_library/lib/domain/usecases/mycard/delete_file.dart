import 'package:get/get.dart';
import 'package:my_library/data/repository/firebase_storage/delete_file_api.dart';

class DeleteFile {
  static Future<void> deleteFile({required String url}) async {
    try {
      DeleteFileApi.deleteFileApi(url: url);
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          duration: const Duration(seconds: 2),
          message: e.toString(),
        ),
      );
    }
  }
}
