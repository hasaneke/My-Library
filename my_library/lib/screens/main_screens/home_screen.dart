import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:my_library/controllers/auth_controller.dart';
import 'package:my_library/database.dart';
import 'package:my_library/models/category.dart';
import 'package:my_library/res/custom_colors.dart';
import 'package:my_library/routes/app_pages.dart';
import 'package:my_library/screens/widgets/add_category_dialog.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final authController = Get.put(AuthController());
  final databaseController = Get.put(DatabaseController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: context.theme.iconTheme,
          backgroundColor: context.theme.scaffoldBackgroundColor,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Get.defaultDialog(
                    title: 'add_category_title'.tr,
                    content: AddCategoryDialog(),
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
        drawer: Theme(
          data: context.theme.copyWith(
            canvasColor: context.theme.scaffoldBackgroundColor,
          ),
          child: Drawer(
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 20,
                          height: 1,
                          color: Colors.black,
                        ),
                        Text(
                          'my_library'.tr,
                          style: TextStyle(fontSize: 27),
                        ),
                        Container(
                          width: 20,
                          height: 1,
                          color: Colors.black,
                        ),
                      ],
                    ))),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: Text('settings'.tr,
                      style: context.theme.textTheme.bodyText2),
                  onTap: () {
                    Get.toNamed(Routes.SETTINGS);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: Text('sign_out'.tr,
                      style: context.theme.textTheme.bodyText2),
                  onTap: () {
                    authController.signOut();
                  },
                )
              ],
            ),
          ),
        ),
        body: Obx(
          () {
            if (databaseController.isCategoriesLoading.value) {
              return Center(
                  child: CircularProgressIndicator(
                color: Palette.colorButtons['black'],
              ));
            } else {
              final List categories =
                  databaseController.categories.map((category) {
                return categoryItem(category);
              }).toList();
              return categoryGridView(categories, context);
            }
          },
        ));
  }

  Padding categoryGridView(List<dynamic> categories, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: GridView.builder(
        itemBuilder: (BuildContext context, index) {
          return categories[index];
        },
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 25,
            mainAxisSpacing: 25,
            crossAxisCount: 3,
            childAspectRatio: 1),
      ),
    );
  }

  GestureDetector categoryItem(Category category) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.CATEGORY_DETAIL, arguments: category);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: category.color!),
        child: Center(
          child: Text(
            category.title!,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: category.color == const Color(0xcc0f0c08)
                    ? Colors.white
                    : Colors.black,
                fontSize: 17),
          ),
        ),
      ),
    );
  }
}
