// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_library/data/models/MyCard/abstractions/my_card_firebase.dart';

import 'package:my_library/screens/presentation_screens/controller/auth_controller.dart';
import 'package:my_library/data/models/category/category.dart';
import 'package:my_library/data/models/MyCard/my_card.dart';

import 'package:uuid/uuid.dart';

class DatabaseController extends GetxController {
  late AuthController authController;

  var categories = RxList<Category>([]);
  var categoriesWithMap = RxMap<String, Category>({});
  var isCategoriesLoading = false.obs;
  var isItemUploading = false.obs;
  late String userId;

  void addCategory({
    String? title,
    Color? color,
  }) async {
    String uniqueId = Uuid().v1();
    try {
      await FirebaseFirestore.instance
          .doc('users/$userId/categories/$uniqueId')
          .set({
        'uniqueId': uniqueId,
        'title': title,
        'color': color!.value,
      }).then((value) {
        final newCat = Category(
            uniqueId: uniqueId,
            title: RxString(title!),
            color: color,
            path: 'users/$userId/categories/$uniqueId');

        categoriesWithMap['users/$userId/categories/$uniqueId'] = newCat;

        Get.back();
      });
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  @override
  void onInit() async {
    authController = Get.put(AuthController());

    userId = authController.user.value!.uid;
    isCategoriesLoading.value = true;

    await FirebaseFirestore.instance
        .collection('/users/$userId/categories/')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        var newCategory = Category(
          uniqueId: doc['uniqueId'],
          title: RxString(doc['title']),
          color: Color(doc['color']),
          path: doc.reference.path,
          previous_path: null,
        );
        categoriesWithMap[doc.reference.path] = newCategory;
        log(doc.reference.path);
      });

      isCategoriesLoading.value = false;
    }).catchError((e) {
      log(e.toString());
      isCategoriesLoading.value = false;
    });

    super.onInit();
  }
}
