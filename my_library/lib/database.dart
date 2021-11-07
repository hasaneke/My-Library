// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:my_library/controllers/auth_controller.dart';

import 'package:my_library/models/category.dart';
import 'package:my_library/models/my_card.dart';
import 'package:intl/intl.dart';

import 'package:uuid/uuid.dart';

class DatabaseController extends GetxController {
  late AuthController authController;

  var categories = RxList<Category>([]);
  var isCategoriesLoading = false.obs;
  var isItemLoading = false.obs;
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
            title: RxString(title!),
            color: color,
            path: 'users/$userId/categories/$uniqueId'));
        Get.back();
      });
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  void deleteCategory(Category category) async {
    await FirebaseFirestore.instance
        .doc(category.path!)
        .delete()
        .then((value) async {
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
      if (category.previous_path == null) {
        categories.remove(category);
        Get.back();
      } else {
        final Category category_controller = Get.find(tag: category.path);
        category_controller.alt_categories.clear();
        final Category previous_category =
            Get.find(tag: category.previous_path);
        previous_category.alt_categories.remove(category);
        Get.back();
      }
    });
  }

  Future<void> editCategory(String newTitle, Category category) async {
    await FirebaseFirestore.instance.doc(category.path!).update({
      'title': newTitle,
    });
    Category choosenCategory = Get.find(tag: category.path);
    choosenCategory.title!.value = newTitle;
  }

  Future<void> addCard(Map<String, RxString> values, String path,
      RxList<XFile> selectedImages) async {
    String uniqueId = Uuid().v1();
    isItemLoading.value = true;
    try {
      await FirebaseFirestore.instance
          .collection('$path/items')
          .doc(uniqueId)
          .set({
        'title': values['title']!.value,
        'short_exp': values['short_exp']!.value,
        'long_exp': values['long_exp']!.value,
        'date': DateTime.now().toString(),
      }).then((value) {
        final Category category_controller = Get.find(tag: path);
        final newCard = MyCard(
          path: '$path/items/$uniqueId',
          title: values['title'],
          shortExp: values['short_exp'],
          longExp: values['long_exp'],
          dateTime: DateTime.now(),
        );
        RxList<Image> convertedToImage = selectedImages
            .map((element) => Image.file(File(element.path)))
            .toList()
            .obs;
        newCard.images = convertedToImage;
        selectedImages.forEach((element) {
          log('image is uploaded');
          uploadImage('$path/items/$uniqueId/images', element).then((value) {
            category_controller.cards.add(newCard);

            isItemLoading.value = false;
            Get.back();
          });
        });
      });
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<void> uploadImage(String path, XFile? xFile) async {
    var idForImage = Uuid().v1();
    var pathForImage = '$path/$idForImage';
    final ref = FirebaseStorage.instance.ref(pathForImage);

    File image = File(xFile!.path);
    await ref.putFile(image);
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
            previous_path: null,
            title: RxString(doc['title']),
            color: Color(doc['color']),
            path: doc.reference.path);
        categories.add(newCategory);
        log(doc.reference.path);
      });

      isCategoriesLoading.value = false;
    });

    super.onInit();
  }
}
