import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:my_library/core/utils/consts/signed_user.dart';
import 'package:my_library/data/models/category/my_category.dart';

import 'package:my_library/presentation/core/usecases/add_category.dart';
import 'package:uuid/uuid.dart';

class AddCategoryDialogController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String title = '';
  Color selectedColor = const Color(0xcc0f0c08);

  Future<void> addMainCategory() async {
    formKey.currentState!.save();
    String pathForMainCategory =
        'users/${SignedUser.getUser()!.uid}/categories/' + const Uuid().v1();
    var newMainCategory = MyCategory(
        path: pathForMainCategory,
        title: RxString(title),
        color: selectedColor);
    AddCategory.addMainCategory(mainCategory: newMainCategory);
    Get.back();
  }

  Future<void> addSubCategory({required String containerPath}) async {
    formKey.currentState!.save();
    String pathForSubCategory =
        containerPath + '/categories/' + const Uuid().v1();
    var newSubCategory = MyCategory(
        containerCategoryPath: containerPath,
        path: pathForSubCategory,
        title: RxString(title),
        color: selectedColor);
    AddCategory.addSubCategory(subCategory: newSubCategory);
    Get.back();
  }
}
