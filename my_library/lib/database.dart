// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:developer';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:my_library/controllers/auth_controller.dart';
import 'package:my_library/controllers/category_detail_screen_controller.dart';
import 'package:my_library/models/category.dart';

import 'package:uuid/uuid.dart';

class DatabaseController extends GetxController {
  late AuthController authController;
  late CategoryDetailScreenController categoryDetailScreenController;
  var categories = RxList<Category>([]);
  var isCategoriesLoading = false.obs;
  late String userId;

  void addCategory({
    @required String? title,
    @required Color? color,
  }) async {
    String uniqueId = Uuid().v1();

    try {
      await FirebaseFirestore.instance
          .doc('users/$userId/categories/$uniqueId')
          .set({
        'title': title,
        'color': color!.value,
      }).then((value) {
        categories.add(Category(
            title: title,
            color: color,
            path: 'users/$userId/categories/$uniqueId'));
        Get.back();
      });
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  void addAltCategory(String? title, Color? color, Category? category) async {
    String uniqueId = Uuid().v1();
    await FirebaseFirestore.instance
        .collection('${category!.path}/categories')
        .doc(uniqueId)
        .set({
      'title': title,
      'color': color!.value,
    }).then((value) {
      final newCategory = Category(
          title: title,
          color: color,
          path: '${category.path}/categories/$uniqueId');
      category.alt_categories.add(newCategory);

      Get.back();
    });
  }

  @override
  void onInit() async {
    authController = Get.put(AuthController());
    categoryDetailScreenController = Get.put(CategoryDetailScreenController());
    userId = authController.user.value!.uid;
    isCategoriesLoading.value = true;

    await FirebaseFirestore.instance
        .collection('/users/$userId/categories/')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        categories.add(Category(
            title: doc['title'],
            color: Color(doc['color']),
            path: doc.reference.path));
      });

      isCategoriesLoading.value = false;
    });
    super.onInit();
  }
}
