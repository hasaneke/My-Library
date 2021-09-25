// ignore_for_file: avoid_function_literals_in_foreach_calls

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
  RxBool isCategoriesLoading = false.obs;
  Future<void> addCategory({String? title, Color? color, String? path}) async {
    var uId = const Uuid().v1();
    if (path == null) {
      // That means we add it for time
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
    } else {
      FirebaseFirestore.instance
          .doc(path)
          .collection('categories')
          .doc(uId)
          .set({
        'title': title,
        'color': color!.value,
        'path': '$path/categories/$uId',
      }).then((value) {
        Category newCategory =
            Category(color: color, title: title, path: '$path/categories/$uId');
        categories
            .firstWhere((category) => category.path == path)
            .altCategories!
            .add(newCategory);
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
          String path = doc.reference.path;
          var newCategory = Category(
            title: doc['title'],
            color: Color(doc['color']),
            path: path,
          );

          categories.add(newCategory);
        },
      );
      isCategoriesLoading.value = false;
    });
    log(categories[2].altCategories!.isEmpty.toString());
    super.onInit();
  }
}
