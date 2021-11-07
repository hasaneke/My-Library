import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:my_library/controllers/auth_controller.dart';
import 'package:my_library/database.dart';

import 'package:my_library/screens/main_screens/widgets/add_category_dialog.dart';
import 'package:my_library/screens/main_screens/widgets/category_gridview.dart';
import 'package:my_library/routes/app_pages.dart';

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
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
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
                          style: const TextStyle(fontSize: 27),
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
                      style: context.theme.textTheme.bodyText1),
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
                      style: context.theme.textTheme.bodyText1),
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
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              ));
            } else {
              if (databaseController.categories.isNotEmpty) {
                return CategoryGridView(databaseController.categories);
              } else {
                return const Center(
                    child: (Text(
                  'Empty',
                  style: TextStyle(color: Colors.black),
                )));
              }
            }
          },
        ));
  }
}
