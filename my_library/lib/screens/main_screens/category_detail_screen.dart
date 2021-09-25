import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

import 'package:my_library/models/category.dart';

import 'package:my_library/screens/main_screens/widgets/add_category_dialog.dart';

class CategoryDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Category category = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                  title: 'add_category_title'.tr,
                  content: AddCategoryDialog(
                    path: category.path,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15));
            },
            icon: Icon(
              Icons.add_to_photos_outlined,
              color: context.theme.iconTheme.color,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
