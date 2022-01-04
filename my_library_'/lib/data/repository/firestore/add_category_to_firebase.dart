import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:my_library/data/models/category/my_category.dart';

class AddCategoryToFirebase {
  static Future<void> addCategoryToFirebase(
      {required MyCategory myCategory}) async {
    try {
      FirebaseFirestore.instance
          .doc(myCategory.path)
          .set(myCategory.fromMyCategoryToDoc);
    } on FirebaseException catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: e.message,
      ));
    }
  }
}
