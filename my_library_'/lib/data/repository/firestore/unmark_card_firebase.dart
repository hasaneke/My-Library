import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_library/data/models/card/my_card.dart';

class UnMarkCardFirebaseApi {
  static Future<void> unMarkCardFirebaseApi(MyCard myCard) async {
    try {
      await FirebaseFirestore.instance
          .doc(myCard.path)
          .update({'isMarked': myCard.isMarked!.value});
    } on FirebaseException catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: e.message,
        duration: Duration(seconds: 2),
      ));
    }
  }
}
