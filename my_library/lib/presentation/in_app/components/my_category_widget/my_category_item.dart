import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/core/utils/routers/app_pages.dart';
import 'package:my_library/data/models/category/my_category.dart';

// ignore: must_be_immutable
class MyCategoryItem extends StatelessWidget {
  MyCategory myCategory;
  // ignore: use_key_in_widget_constructors
  MyCategoryItem(this.myCategory);

  @override
  Widget build(BuildContext context) {
    MyCategory controller = Get.find(tag: myCategory.path);

    return GestureDetector(
      onTap: () async {
        Get.toNamed(Routes.CATEGORY_DETAIL_SCREEN_ROUTE,
            arguments: myCategory, preventDuplicates: false);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: controller.color),
        child: Center(
            child: Obx(
          () => Text(
            controller.title.value,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: controller.color == const Color(0xcc0f0c08)
                    ? Colors.white
                    : Colors.black,
                fontSize: 15),
          ),
        )),
      ),
    );
  }
}
