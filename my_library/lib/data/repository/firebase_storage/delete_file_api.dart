import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:my_library/data/models/card/my_card.dart';

class DeleteFileApi {
  static Future<void> deleteFileApi(String pathToDelete) async {
    try {
      await FirebaseStorage.instance.refFromURL(pathToDelete).delete();
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
