import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UpdateCategoryTitleFirestoreApi {
  static Future<void> updateTitleOnFirebase(
      String newTitle, String path) async {
    try {
      await FirebaseFirestore.instance.doc(path).update({
        'title': newTitle,
      });
    } on FirebaseException catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: e.message,
      ));
    }
  }
}
