import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_library/data/models/card/my_card.dart';

class AddMyCardToFirestoreApi {
  static Future<void> addMyCardToFirebase(
    MyCard myCard,
  ) async {
    try {
      FirebaseFirestore.instance.doc(myCard.path).set(myCard.toDoc);
    } on FirebaseException catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: e.message,
        duration: const Duration(seconds: 3),
      ));
    }
  }
}
