import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:my_library/controllers/auth_controller.dart';
import 'package:my_library/database.dart';
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
          return Column(
            children: databaseController.categories.map((category) {
              return Text(
                category.title!,
                style: const TextStyle(color: Colors.black),
              );
            }).toList(),
          );
        }));
  }
}
