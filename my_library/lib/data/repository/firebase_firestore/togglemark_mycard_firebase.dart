import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_library/data/models/card/my_card.dart';

class ToggleMyCardFirestoreApi {
  static Future<void> toggleMarkMyCardFirebaseApi(MyCard myCard) async {
    try {
      await FirebaseFirestore.instance
          .doc(myCard.path)
          .update({'isMarked': myCard.isMarked!.value});
    } on FirebaseException catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: e.message,
        duration: const Duration(seconds: 2),
      ));
    }
  }
}
