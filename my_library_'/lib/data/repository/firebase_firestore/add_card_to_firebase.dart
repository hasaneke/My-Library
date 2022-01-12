import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_library/data/models/card/my_card.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class AddMyCardToFirebase {
  static Future<void> addMyCardToFirebase(MyCard myCard) async {
    try {
      FirebaseFirestore.instance.doc(myCard.path).set(myCard.toDoc);
      _uploadFilesToFirebaseStorage(myCard);
    } on FirebaseException catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: e.message,
        duration: const Duration(seconds: 3),
      ));
    }
  }

  static Future<void> _uploadFilesToFirebaseStorage(MyCard myCard) async {
    try {
      for (var file in myCard.imageFiles!.values) {
        String uniquePathForFile = myCard.path + "/images/" + const Uuid().v1();
        await FirebaseStorage.instance.ref(uniquePathForFile).putFile(file);
      }
      for (var file in myCard.otherFiles!.values) {
        String uniquePathForFile =
            myCard.path + "/otherfiles/" + const Uuid().v1();
        await FirebaseStorage.instance.ref(uniquePathForFile).putFile(file);
      }
    } on FirebaseException catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: e.message,
        duration: const Duration(seconds: 3),
      ));
    }
  }
}
