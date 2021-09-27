import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/controllers/category_detail_screen_controller.dart';

import 'package:my_library/models/category.dart';

import '../category_detail_screen.dart';

class CategoryItem extends StatelessWidget {
  Category category;
  CategoryItem(this.category);
  final CategoryDetailScreenController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (category.alt_categories.isEmpty) {
          category.fetchAltCategories().then((value) {
            Get.to(() => CategoryDetailScreen(),
                preventDuplicates: false, arguments: category);
          });
        } else {
          Get.to(() => CategoryDetailScreen(),
              preventDuplicates: false, arguments: category);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: category.color!),
        child: Center(
          child: Text(
            category.title!,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: category.color == const Color(0xcc0f0c08)
                    ? Colors.white
                    : Colors.black,
                fontSize: 17),
          ),
        ),
      ),
    );
  }
}
