import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:my_library/controllers/auth_controller.dart';
import 'package:my_library/database.dart';
import 'package:my_library/models/category.dart';
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
          leading: IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.black),
            onPressed: () {
              authController.signOut();
            },
          ),
        ),
        body: Obx(() {
          final List categories = databaseController.categories.map((category) {
            return categoryItem(category);
          }).toList();
          return categoryGridView(categories);
        }));
  }

  Padding categoryGridView(List<dynamic> categories) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 25,
            mainAxisSpacing: 25,
            crossAxisCount: 3,
            childAspectRatio: 1),
        itemBuilder: (BuildContext context, index) {
          return categories[index];
        },
        itemCount: categories.length,
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
                color: category.color == Color(0xcc0f0c08)
                    ? Colors.white
                    : Colors.black,
                fontSize: 17),
          ),
        ),
      ),
    );
  }
}
