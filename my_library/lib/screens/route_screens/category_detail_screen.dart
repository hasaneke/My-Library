import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:my_library/controllers/category_detail_screen_controller.dart';
import 'package:my_library/models/my_card.dart';

import 'package:my_library/models/category.dart';
import 'package:my_library/res/pop_up_menu_constants.dart';
import 'package:my_library/routes/app_pages.dart';
import 'package:intl/intl.dart';
import 'package:my_library/components/add_category_dialog.dart';
import 'package:my_library/components/card_item.dart';
import 'package:my_library/components/category_gridview.dart';

class CategoryDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _textEditingController = TextEditingController();

    Category category_controller = Get.find(tag: Get.arguments);

    final CategoryDetailScreenController controller =
        Get.put(CategoryDetailScreenController(), tag: Get.arguments);

    _textEditingController.text = category_controller.title!.value;

    AppBar appBar(TextEditingController _textEditingController,
            BuildContext context) =>
        AppBar(
          title: Obx(() => Center(
              child: controller.editTitle.value
                  ? TextField(
                      controller: _textEditingController,
                      onSubmitted: (text) {
                        category_controller.changeTitle(text).then(
                            (value) => controller.editTitle.value = false);
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
                      path: category_controller.path,
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
                  controller.onPopUpSelected(item, category_controller),
              itemBuilder: (context) => PopUpMenuConstants.choices
                  .map((choice) => PopupMenuItem<int>(child: Text(choice.tr)))
                  .toList(),
            )
          ],
        );

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Obx(() {
        if (category_controller.alt_categories.isEmpty &&
            category_controller.cards.isEmpty) {
          return SingleChildScrollView(
            child: Column(
              children: [
                appBar(_textEditingController, context),
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      AppBar().preferredSize.height,
                  child: const Center(
                    child: Text('Empty'),
                  ),
                ),
              ],
            ),
          );
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                appBar(_textEditingController, context),
                category_controller.alt_categories.isNotEmpty
                    ? controller.isCatOpened.value
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: EdgeInsets.only(top: 9),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.black54, width: 2)),
                              child: Column(
                                children: [
                                  CategoryGridView(
                                      category_controller.altCategoriesWithMap),
                                  IconButton(
                                      onPressed: () => controller.toggleCat(),
                                      icon: const Icon(
                                        Icons.arrow_upward,
                                        color: Colors.black54,
                                      ))
                                ],
                              ),
                            ),
                          )
                        : IconButton(
                            onPressed: () => controller.toggleCat(),
                            icon: const Icon(Icons.grid_view))
                    : Container(),
                ListView.builder(
                  controller: ScrollController(keepScrollOffset: true),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, index) {
                    var card =
                        category_controller.cards.values.elementAt(index);
                    return CardItem(card);
                  },
                  itemCount: category_controller.cards.length,
                ),
              ],
            ),
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            context.theme.floatingActionButtonTheme.backgroundColor,
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () {
          final String path = category_controller.path;
          Get.toNamed(Routes.ADDITEM, arguments: path);
        },
      ),
    );
  }
}
