import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/data/models/category.dart';

import 'category_item.dart';

class CategoryGridView extends StatelessWidget {
  Map<String, Category> categories;
  CategoryGridView(this.categories);
  @override
  Widget build(BuildContext context) {
    List<CategoryItem> convertedToWidgetsList = categories.values
        .map((category) {
          return CategoryItem(category);
        })
        .toList()
        .obs;
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: GridView.builder(
        itemBuilder: (BuildContext context, index) {
          return convertedToWidgetsList[index];
        },
        controller: ScrollController(keepScrollOffset: true),
        shrinkWrap: true,
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 35,
            mainAxisSpacing: 35,
            crossAxisCount: 3,
            childAspectRatio: 1),
      ),
    );
  }
}
