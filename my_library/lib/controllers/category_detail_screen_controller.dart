import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_library/models/category.dart';

class CategoryDetailScreenController extends GetxController {
  var nextAltCategories = RxList<Category>([]);

  void onPopUpSelected(int item, Category category) async {
    switch (item) {
      case 0:
        log('edit category');
        break;
      case 1:
        await FirebaseFirestore.instance
            .doc(category.path!)
            .delete()
            .then((value) {});

        if (category.alt_categories.isNotEmpty) {
          await FirebaseFirestore.instance
              .collection('${category.path}/categories')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              doc.reference.delete();
            });
          });
        }
        break;
    }
  }
}
