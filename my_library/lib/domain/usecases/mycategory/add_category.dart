import 'dart:developer';

import 'package:get/get.dart';
import 'package:my_library/data/models/category/my_category.dart';
import 'package:my_library/data/repository/firebase_firestore/add_category_to_firebase.dart';
import 'package:my_library/domain/data/datastore_controller.dart';

class AddCategory {
  static Future<void> addMainCategory(
      {required MyCategory mainCategory}) async {
    try {
      AddCategoryToFirestoreApi.addCategoryToFirebase(myCategory: mainCategory);
      DatastoreController datastoreController = Get.find();
      datastoreController.addMainCategory(mainCategory);

      Get.put(mainCategory, tag: mainCategory.path, permanent: true);
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> addSubCategory({required MyCategory subCategory}) async {
    try {
      AddCategoryToFirestoreApi.addCategoryToFirebase(myCategory: subCategory);
      MyCategory containerCategory =
          Get.find(tag: subCategory.containerCategoryPath);
      containerCategory.addSubCategory(subCategory);

      Get.put(subCategory, tag: subCategory.path, permanent: true);
    } catch (e) {
      log(e.toString());
    }
  }
}
