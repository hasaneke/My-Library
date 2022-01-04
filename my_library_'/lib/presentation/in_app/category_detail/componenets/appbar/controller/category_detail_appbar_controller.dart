import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/data/models/category/my_category.dart';

import 'package:my_library/presentation/in_app/components/add_category_dialog/add_category_dialog.dart';

class CategoryDetailAppbarController extends GetxController {
  MyCategory myCategory;
  CategoryDetailAppbarController(this.myCategory);

  RxBool editTitle = false.obs;
  TextEditingController textEditingController = TextEditingController();

  onPopUpSelected(String choice) {
    switch (choice) {
      case 'edit':
        editTitle.value = true;
        break;
      case 'delete':
        deleteCategory();
        break;
    }
  }

  openDiaolog() {
    Get.defaultDialog(
        title: 'add_category_title'.tr,
        content: AddCategoryDialog(
          pathToSave: myCategory.path,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15));
  }

  deleteCategory() async {
    myCategory.destroy();
    Get.back();
  }

  changeTitle({required String newTitle}) {
    myCategory.changeTitle(newTitle);
    editTitle.value = false;
  }

  @override
  void onInit() {
    textEditingController.text = myCategory.title.value;
    super.onInit();
  }
}
