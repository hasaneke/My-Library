import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DeleteCategoryFromFirebaseApi {
  static Future<void> deleteCategoryFromFirebaseApi(String path) async {
    try {
      FirebaseFirestore.instance.doc(path).delete();
    } on FirebaseException catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: e.message,
      ));
    }
  }
}
