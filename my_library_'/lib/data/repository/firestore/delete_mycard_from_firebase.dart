import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

class DeleteMyCardFromFirebaseApi {
  static Future<void> deleteMyCardFromFirebaseApi(String pathToCard) async {
    try {
      log("card:" + pathToCard);
      FirebaseFirestore.instance.doc(pathToCard).delete();
    } on FirebaseException catch (e) {
      Get.showSnackbar(GetSnackBar(message: e.message));
    }
  }
}
