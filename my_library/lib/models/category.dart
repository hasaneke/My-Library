import 'dart:developer';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/database.dart';
import 'package:my_library/models/my_card.dart';
import 'package:intl/intl.dart';

class Category extends GetxController {
  String? path; // Path to category
  String? previous_path;
  RxString? title;
  Color? color;
  var editTitle = false.obs;
  RxBool isFetched = false.obs;

  var alt_categories = RxList<Category>([]);
  var cards = RxList<MyCard>([]);
  Category({
    @required this.title,
    @required this.color,
    @required this.path,
    this.previous_path,
  });

  Future<void> fetchData(String? previousPath) async {
    await FirebaseFirestore.instance
        .collection('$path/categories')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        alt_categories.add(
          Category(
            title: RxString(doc['title']),
            color: Color(doc['color']),
            path: doc.reference.path,
            previous_path: previousPath,
          ),
        );
      });
    });
    await FirebaseFirestore.instance
        .collection('$path/items')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        cards.add(
          MyCard(
              path: doc.reference.toString(),
              title: RxString(doc['title']),
              shortExp: RxString(doc['short_exp']),
              longExp: RxString(doc['long_exp']),
              dateTime: DateTime.parse(doc['date'])),
        );
      });
    }).then((value) {
      isFetched.value = true;
    });
  }

  Future<void> fetchItems(String path) async {}

  void onPopUpSelected(int item, Category category) async {
    switch (item) {
      case 0:
        editTitle.value = true;

        break;
      case 1:
        final DatabaseController database_controller = Get.find();
        database_controller.deleteCategory(category);
        break;
    }
  }

  Future<void> changeTitle(Category category) async {
    await FirebaseFirestore.instance.doc(category.path!).update({
      'title': category.title!.value,
    }).then((value) {
      if (category.previous_path == null) {
        final Category edited_category = Get.find(tag: category.path);
        edited_category.title = category.title;
      } else {
        final Category category_controller = Get.find(tag: category.path);
        category_controller.title!.value = category.title!.value;
      }
    });
  }
}
