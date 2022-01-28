import 'package:get/get.dart';
import 'package:my_library/data/repository/firebase_storage/delete_file_api.dart';

class DeleteFile {
  static Future<void> deleteFile(String pathToDelete) async {
    try {
      DeleteFileApi.deleteFileApi(pathToDelete);
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          duration: Duration(seconds: 2),
          message: e.toString(),
        ),
      );
    }
  }
}
