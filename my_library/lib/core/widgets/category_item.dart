// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:my_library/domain/models/category.dart';
import 'package:my_library/core/utils/routers/app_pages.dart';
import 'package:my_library/core/utils/theme/themes.dart';

class CategoryItem extends StatelessWidget {
  Category category;

  // ignore: use_key_in_widget_constructors
  CategoryItem(this.category);

  @override
  Widget build(BuildContext context) {
    Category category_controller = Get.put(category, tag: category.path);
    log('created');
    return GestureDetector(
      onTap: () async {
        Get.toNamed(Routes.CATEGORY_DETAIL,
            preventDuplicates: false, arguments: category.path);
        //   category_controller.fetchData().then((value) {
        //     category_controller.isFetched = true;
        //     Get.toNamed(Routes.CATEGORY_DETAIL,
        //         preventDuplicates: false, arguments: category.path);
        //   });
        // } else {
        //   Get.toNamed(Routes.CATEGORY_DETAIL,
        //       preventDuplicates: false, arguments: category.path);
        // }
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
