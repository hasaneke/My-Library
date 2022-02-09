import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FetchCategoriesFromFirestoreApi {
  static Future<QuerySnapshot?> fetchCategoriesApi(String path) async {
    try {
      return await FirebaseFirestore.instance.collection(path).get();
    } on FirebaseException catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: e.message,
      ));
      return null;
    }
  }
}
