import 'dart:ui';

import 'package:my_library/models/item.dart';

class Category {
  Category({this.path, this.title, this.color});

  String? path; // Path to category
  String? title;
  Color? color;
  List<Category> altCategories = [];
  List<Item> items = [];
}
