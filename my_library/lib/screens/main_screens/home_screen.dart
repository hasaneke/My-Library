import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:my_library/controllers/auth_controller.dart';
import 'package:my_library/screens/widgets/add_category_dialog.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                  title: 'Add Category', content: AddCategoryDialog());
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
    );
  }
}
