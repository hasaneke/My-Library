import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:my_library/models/category.dart';

import '../category_detail_screen.dart';

class CategoryItem extends StatelessWidget {
  Category category;

  CategoryItem(this.category);

  @override
  Widget build(BuildContext context) {
    Category category_controller = Get.put(category, tag: category.path);
    log('created');
    return GestureDetector(
      onTap: () async {
        if (!category_controller.isFetched) {
          category_controller.fetchData().then((value) {
            category.isFetched = true;
            Get.to(() => CategoryDetailScreen(),
                preventDuplicates: false, arguments: category_controller.path);
          });
        } else {
          Get.to(() => CategoryDetailScreen(),
              preventDuplicates: false,
              arguments: category_controller.path as String);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: category_controller.color!),
        child: Center(
            child: Obx(
          () => Text(
            category_controller.title!.value,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: category.color == const Color(0xcc0f0c08)
                    ? Colors.white
                    : Colors.black,
                fontSize: 15),
          ),
        )),
      ),
    );
  }
}
