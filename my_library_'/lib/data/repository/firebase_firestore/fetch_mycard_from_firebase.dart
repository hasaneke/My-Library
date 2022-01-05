import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FetchMyCardsFromFirebase {
  static Future<QuerySnapshot?> fetchMyCardsFromFirebaseApi(
      String catPath) async {
    try {
      return await FirebaseFirestore.instance
          .collection(catPath + '/cards')
          .get();
    } catch (e) {
      log(catPath);
      Get.showSnackbar(GetSnackBar(
        message: e.toString(),
        duration: const Duration(seconds: 3),
      ));
      return null;
    }
  }
}
