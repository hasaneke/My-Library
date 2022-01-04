import 'package:flutter/material.dart';
import 'package:my_library/data/models/category/my_category.dart';
import 'package:my_library/presentation/in_app/components/my_category_widget/my_category_item.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MyCategoryGridView extends StatelessWidget {
  Map<String, MyCategory> categories;
  // ignore: use_key_in_widget_constructors
  MyCategoryGridView(this.categories);
  @override
  Widget build(BuildContext context) {
    List<MyCategoryItem> convertedToWidgetsList = categories.values
        .map((category) {
          return MyCategoryItem(category);
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
