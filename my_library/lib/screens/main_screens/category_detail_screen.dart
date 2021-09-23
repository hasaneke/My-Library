import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:my_library/models/category.dart';

class CategoryDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Category category = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Center(
        child: Text(category.title!),
      ),
    );
  }
}
