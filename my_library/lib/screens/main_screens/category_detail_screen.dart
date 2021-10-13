import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:my_library/controllers/category_detail_screen_controller.dart';
import 'package:my_library/models/my_card.dart';

import 'package:my_library/models/category.dart';
import 'package:my_library/res/pop_up_menu_constants.dart';
import 'package:my_library/routes/app_pages.dart';
import 'package:intl/intl.dart';
import 'package:my_library/screens/main_screens/widgets/add_category_dialog.dart';
import 'package:my_library/screens/main_screens/widgets/card_item.dart';
import 'package:my_library/screens/main_screens/widgets/category_gridview.dart';

class CategoryDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _textEditingController = TextEditingController();
    final Category category = Get.arguments;
    final CategoryDetailScreenController controller =
        Get.put(CategoryDetailScreenController());

    final Category category_controller = Get.find(tag: category.path);
    int i = 0;
    category_controller.editTitle.value = false;
    _textEditingController.text = category.title!.value;
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Center(
            child: category_controller.editTitle.value
                ? TextField(
                    controller: _textEditingController,
                    onSubmitted: (text) {
                      category_controller.changeTitle(Category(
                          title: RxString(text),
                          previous_path: category_controller.previous_path,
                          color: category_controller.color,
                          path: category_controller.path));
                      category_controller.editTitle.value = false;
                    })
                : Text(category_controller.title!.value))),
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
            onSelected: (item) =>
                category_controller.onPopUpSelected(item, category),
            itemBuilder: (context) => PopUpMenuConstants.choices
                .map((choice) =>
                    PopupMenuItem<int>(value: i++, child: Text(choice.tr)))
                .toList(),
          )
        ],
      ),
      body: Obx(() {
        if (category_controller.alt_categories.isEmpty &&
            category_controller.cards.isEmpty) {
          return const Center(
            child: Text('Empty'),
          );
        } else {
          return ListView.builder(
            itemBuilder: (BuildContext context, index) {
              var card = category_controller.cards[index];
              return CardItem(card);
            },
            itemCount: category_controller.cards.length,
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            context.theme.floatingActionButtonTheme.backgroundColor,
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () {
          Get.toNamed(Routes.ADDITEM, arguments: category.path);
        },
      ),
    );
  }
}
