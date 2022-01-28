import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/presentation/domain/data/datastore_controller.dart';
import 'package:my_library/presentation/in_app/components/my_category_gridview/my_category_gridview.dart';

import 'package:my_library/presentation/in_app/tabbar/pages/tabs/home/controller/home_controller.dart';
import 'package:my_library/presentation/in_app/tabbar/pages/tabs/home/pages/my_drawer/my_drawer.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class HomeScreen extends GetView<HomeController> {
  DatastoreController datastoreController = Get.put(DatastoreController());
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
            onPressed: () => controller.openAddCategoryDialog(),
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
        child: const MyDrawer(),
      ),
      // ignore: invalid_use_of_protected_member
      body: Obx(() => controller.maincategories.value.isNotEmpty
          // ignore: invalid_use_of_protected_member
          ? MyCategoryGridView(controller.maincategories.value)
          : const Center(
              child: Text('Empty'),
            )),
    );
  }
}
