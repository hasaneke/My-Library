import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:my_library/controllers/category_detail_screen_controller.dart';

import 'package:my_library/models/category.dart';
import 'package:my_library/res/pop_up_menu_constants.dart';
import 'package:my_library/routes/app_pages.dart';

import 'package:my_library/screens/main_screens/widgets/add_category_dialog.dart';
import 'package:my_library/screens/main_screens/widgets/category_gridview.dart';

class CategoryDetailScreen extends GetView<CategoryDetailScreenController> {
  @override
  Widget build(BuildContext context) {
    final Category category = Get.arguments;
    int i = 0;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(category.title!)),
        foregroundColor: Colors.black,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                  title: 'add_category_title'.tr,
                  content: AddCategoryDialog(
                    category: category,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15));
            },
            icon: Icon(
              Icons.add_to_photos_outlined,
              color: context.theme.iconTheme.color,
              size: 30,
            ),
          ),
          PopupMenuButton<int>(
            onSelected: (item) => controller.onPopUpSelected(item, category),
            itemBuilder: (context) => PopUpMenuConstants.choices
                .map((choice) =>
                    PopupMenuItem<int>(value: i++, child: Text(choice)))
                .toList(),
          )
        ],
      ),
      body: Obx(() => category.alt_categories.isEmpty
          ? CategoryGridView(controller.nextAltCategories)
          : CategoryGridView(category.alt_categories)),
    );
  }
}
