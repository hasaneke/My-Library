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
import 'package:cloud_functions/cloud_functions.dart';

class DatabaseController extends GetxController {
  late AuthController authController;

  var categories = RxList<Category>([]);
  var categoriesWithMap = RxMap<String, Category>({});
  var isCategoriesLoading = false.obs;
  var isItemUploading = false.obs;
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
        final newCat = Category(
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

  Future<void> deleteCategory(Category category) async {
    if (category.cards.isNotEmpty) {
      deleteAllCards(category.path);
    }
    if (category.alt_categories.isNotEmpty) {
      category.altCategoriesWithMap.values.forEach((altCategory) {
        deleteCategory(altCategory);
      });
      // category.altCategoriesWithMap.values.forEach((element) {
      //   category.altCategoriesWithMap.values.forEach((altCategory) {
      //     deleteCategory(altCategory);
      //   });
      // });
    }
    if (category.previous_path != null) {
      Category previousCategory = Get.find(tag: category.previous_path);

      previousCategory.altCategoriesWithMap.remove(category.path);
    } else {
      categoriesWithMap.remove(category.path);
    }
    FirebaseFirestore.instance.doc(category.path).delete();
  }

  Future<void> deleteAllCards(String pathToCat) async {
    FirebaseFirestore.instance
        .collection('$pathToCat/cards')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        deleteOneCard(doc.reference.path);
      });
    });
  }

  Future<void> deleteOneCard(String pathToCard) async {
    await FirebaseFirestore.instance.doc(pathToCard).delete();
    final result =
        await FirebaseStorage.instance.ref("$pathToCard/images").listAll();
    if (result.items.isNotEmpty) {
      result.items.forEach((element) {
        element.delete();
      });
    }
    List<String> pathToItsCat =
        pathToCard.split("/cards"); //This helps us to reach its category path
    Category containerCat = Get.find(tag: pathToItsCat[0]);

    containerCat.cards.remove(pathToCard);
  }

  Future<void> editCategory(String newTitle, Category category) async {
    await FirebaseFirestore.instance.doc(category.path).update({
      'title': newTitle,
    });
    Category choosenCategory = Get.find(tag: category.path);
    choosenCategory.title!.value = newTitle;
  }

  Future<void> addCard(
    Map<String, dynamic> values,
  ) async {
    String uniqueId = Uuid().v1();
    isItemUploading.value = true;
    try {
      await FirebaseFirestore.instance
          .collection('${values['path']}/cards')
          .doc(uniqueId)
          .set({
        'title': values['title']!.value,
        'short_exp': values['short_exp']!.value,
        'long_exp': values['long_exp']!.value,
        'date': DateTime.now().toString(),
      }).then((value) {
        final String pathToCard =
            '${values['path']}/cards/$uniqueId'; //path in firebase firestore
        final newCard = MyCard(
          path: '${values['path']}/cards/$uniqueId',
          title: values['title'],
          shortExp: values['short_exp'],
          longExp: values['long_exp'],
          dateTime: DateTime.now(),
        );
        RxList<Image> fromXFilestoImages = (values['images'] as RxList<XFile>)
            .map((element) {
              return Image.file(File(element.path));
            })
            .toList()
            .obs;

        newCard.images = fromXFilestoImages;
        Category category = Get.find(tag: values['path']);

        category.cards[pathToCard] = newCard;
        uploadImages(
                '${values['path']}/cards/$uniqueId/images', values['images'])
            .then((value) {
          isItemUploading.value = false;

          Get.back();
        });
      });
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<void> uploadImages(String path, RxList<XFile> images) async {
    for (var image in images) {
      var uIdForImage = Uuid().v1();
      final ref = FirebaseStorage.instance.ref("$path/$uIdForImage");

      await ref.putFile(File(image.path));
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
            previous_path: null,
            title: RxString(doc['title']),
            color: Color(doc['color']),
            path: doc.reference.path);
        categoriesWithMap[doc.reference.path] = newCategory;
        log(doc.reference.path);
      });

      isCategoriesLoading.value = false;
    }).catchError((e) {
      Get.showSnackbar(GetBar(title: e.toString()));
      isCategoriesLoading.value = false;
    });

    super.onInit();
  }
}
