import 'dart:developer';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/models/item.dart';

class Category extends GetxController {
  String? path; // Path to category
  String? title;
  Color? color;
  var alt_categories = RxList<Category>([]);
  List<Item>? items = [];
  Category({
    @required this.title,
    @required this.color,
    @required this.path,
  });

  Future<void> fetchAltCategories() async {
    await FirebaseFirestore.instance
        .collection('$path/categories')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        alt_categories.add(Category(
            title: doc['title'],
            color: Color(doc['color']),
            path: doc.reference.path));
      });
    });
  }
}
