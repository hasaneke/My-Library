import 'dart:developer';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:my_library/controllers/auth_controller.dart';
import 'package:my_library/models/category.dart';

import 'package:uuid/uuid.dart';

class DatabaseController extends GetxController {
  // ignore: unused_field
  String? userdId;
  var categories = RxList<Category>([]);
  RxBool isCategoriesLoading = true.obs;
  Future<void> addCategory({String? title, Color? color, String? path}) async {
    if (path == null) {
      // That means we add it for time
      var uId = Uuid().v1();
      FirebaseFirestore.instance
          .collection('/users/$userdId/categories')
          .doc(uId)
          .set({
        'title': title,
        'color': color!.value,
        'path': '/users/$userdId/categories/$uId',
      }).then((value) {
        Category newCategory = Category(
            color: color,
            title: title,
            path: '/users/$userdId/categories/$uId');
        categories.add(newCategory);
        log(newCategory.title!);
        Get.back();
      });
    }
  }

  @override
  void onInit() async {
    userdId = Get.put(AuthController()).user.value!.uid;
    await FirebaseFirestore.instance
        .collection('/users/$userdId/categories')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach(
        (doc) {
          categories.add(Category(
              title: doc['title'],
              color: Color(doc['color']),
              path: doc['path']));
        },
      );
      isCategoriesLoading.value = false;
    });
    super.onInit();
  }
}
