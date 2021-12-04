import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/models/category.dart';

import 'category_item.dart';

class CategoryGridView extends StatelessWidget {
  List<Category?> alt_categories = [];
  CategoryGridView(this.alt_categories);
  @override
  Widget build(BuildContext context) {
    List<CategoryItem> categories = alt_categories.map((category) {
      return CategoryItem(category!);
    }).toList();
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: GridView.builder(
        itemBuilder: (BuildContext context, index) {
          return categories[index];
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
