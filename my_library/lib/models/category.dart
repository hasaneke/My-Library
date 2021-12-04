import 'dart:developer';

import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:my_library/database.dart';
import 'package:my_library/models/my_card.dart';

import 'package:uuid/uuid.dart';

class Category extends GetxController {
  String path; // Path to category
  String? previous_path;
  RxString? title = RxString(' ');
  Color? color;
  RxList<Category> alt_categories = <Category>[].obs;
  var cards = RxList<MyCard?>([]);
  RxMap<String, MyCard> cardsWithMap = RxMap<String, MyCard>({});
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
        alt_categories.add(
          Category(
            title: RxString(doc['title']),
            color: Color(doc['color']),
            path: doc.reference.path,
            previous_path: previous_path,
          ),
        );
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

        // String downloadUrl = await firebase_storage.FirebaseStorage.instance
        //     .ref(
        //         '/users/Oo1LnmAxUEXWKwR7TUT3PdrOrFu2/categories/89af0360-38bf-11ec-a49d-85b9380c22fb/items/099133f0-38c0-11ec-a49d-85b9380c22fb/images/09c69bd0-38c0-11ec-a49d-85b9380c22fb')
        //     .getDownloadURL();

        if (result.items.isNotEmpty) {
          String downloadUrl = await result.items[0].getDownloadURL();
          card.images.add(Image.network(downloadUrl));
        }
        cards.add(
          card,
        );
      });
    });
  }

  void addAltCategory(String? title, Color? color, Category category) async {
    String uniqueId = Uuid().v1();
    await FirebaseFirestore.instance
        .collection('${category.path}/categories')
        .doc(uniqueId)
        .set({
      'title': title,
      'color': color!.value,
    }).then((value) {
      final newCategory = Category(
          title: RxString(title!),
          color: color,
          previous_path: category.path,
          path: '${category.path}/categories/$uniqueId');
      alt_categories.add(newCategory);

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
