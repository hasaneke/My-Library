import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:get/get.dart';

class DeleteMyCardFromFirestoreApi {
  static Future<void> deleteMyCardFromFirebaseApi(String pathToCard) async {
    try {
      _clearFiles(pathToCard);
      FirebaseFirestore.instance.doc(pathToCard).delete();
    } on FirebaseException catch (e) {
      Get.showSnackbar(GetSnackBar(message: e.message));
    }
  }

  static Future<void> _clearFiles(String pathToCard) async {
    final imagesToDelete =
        await FirebaseStorage.instance.ref(pathToCard + "/images/").listAll();
    final otherFilesToDelete = await FirebaseStorage.instance
        .ref(pathToCard + "/otherfiles/")
        .listAll();

    for (var imageFile in imagesToDelete.items) {
      imageFile.delete();
    }

    for (var otherFile in otherFilesToDelete.items) {
      otherFile.delete();
    }
  }
}
