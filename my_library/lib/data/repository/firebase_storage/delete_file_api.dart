import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class DeleteFileApi {
  static Future<void> deleteFileApi({required String url}) async {
    try {
      await FirebaseStorage.instance.refFromURL(url).delete();
      Get.showSnackbar(const GetSnackBar(
        duration: Duration(seconds: 2),
        message: "Deleted!",
      ));
    } on FirebaseException catch (e) {
      Get.showSnackbar(GetSnackBar(
        duration: const Duration(seconds: 2),
        message: e.message,
      ));
    }
  }
}
