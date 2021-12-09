import 'dart:developer';

import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:my_library/models/my_card.dart';

import 'package:uuid/uuid.dart';

class Category extends GetxController {
  String path; // Path to category
  String? previous_path;
  Color? color;

  RxString? title = RxString(' ');
  RxList<Category> alt_categories = <Category>[].obs;
  RxMap<String, Category> altCategoriesWithMap = RxMap<String, Category>({});
  RxMap<String, MyCard> cards = RxMap<String, MyCard>({});
  RxBool isLoading = false.obs;

  Category({
    this.title,
    this.color,
    required this.path,
    this.previous_path,
  });

  late bool isFetched;

  Future<void> fetchData() async {
    await _fetchCategories();
    await _fetchItems();
  }

  Future<void> _fetchCategories() async {
    await FirebaseFirestore.instance
        .collection('$path/categories')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        final altCat = Category(
          title: RxString(doc['title']),
          color: Color(doc['color']),
          path: doc.reference.path,
          previous_path: previous_path,
        );
        alt_categories.add(altCat);
        altCategoriesWithMap[doc.reference.path] = altCat;
      });
    });
  }

  Future<void> _fetchItems() async {
    await FirebaseFirestore.instance
        .collection('$path/cards')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        MyCard card = MyCard(
          path: doc.reference.path,
          title: RxString(doc['title']),
          shortExp: RxString(doc['short_exp']),
          longExp: RxString(doc['long_exp']),
          dateTime: DateTime.parse(doc['date']),
        );
        log(doc.reference.path);
        final result = await firebase_storage.FirebaseStorage.instance
            .ref(doc.reference.path)
            .child('images')
            .listAll();

        if (result.items.isNotEmpty) {
          String downloadUrl = await result.items[0].getDownloadURL();
          card.images.add(Image.network(downloadUrl));
        }

        cards[doc.reference.path] = card;
      });
    });
  }

  void addAltCategory(String? title, Color? color, String path) async {
    String uniqueId = Uuid().v1();
    await FirebaseFirestore.instance
        .collection('$path/categories')
        .doc(uniqueId)
        .set({
      'title': title,
      'color': color!.value,
    }).then((value) {
      final newCategory = Category(
          title: RxString(title!),
          color: color,
          previous_path: path,
          path: '$path/categories/$uniqueId');
      alt_categories.add(newCategory);
      altCategoriesWithMap[path] = newCategory;
      Get.back();
    });
  }

  Future<void> changeTitle(String newTitle) async {
    await FirebaseFirestore.instance.doc(path).update({
      'title': newTitle,
    }).then((value) {
      title!.value = newTitle;
    });
  }

  @override
  void onInit() {
    isFetched = false;
    super.onInit();
  }
}
