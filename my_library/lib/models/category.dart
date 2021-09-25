import 'dart:developer';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/models/item.dart';

class Category {
  String? path; // Path to category
  String? title;
  Color? color;
  List<Category>? altCategories = [];
  List<Item>? items = [];
  Category({@required this.path, @required this.title, @required this.color});
}
