import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_library/core/utils/routers/app_pages.dart';
import 'package:my_library/data/models/category/my_category.dart';
import 'package:my_library/data/repository/firebase_auth/signout_usecase.dart';

import 'package:my_library/presentation/core/data/datastore_controller.dart';
import 'package:my_library/presentation/in_app/components/add_category_dialog/add_category_dialog.dart';

class HomeController extends GetxController {
  final RxMap<String, MyCategory> _maincategories =
      Get.find<DatastoreController>().maincategories;
  RxMap<String, MyCategory> get maincategories => _maincategories;
  signOut() {
    SignoutUsecase.signOut();
    Get.offAllNamed(Routes.LOGIN_SCREEN_ROUTE);
  }

  openAddCategoryDialog() {
    Get.defaultDialog(
      title: 'add_category_title'.tr,
      content: AddCategoryDialog(
        pathToSave: '',
      ),
      contentPadding: const EdgeInsets.all(15),
    );
  }
}
