import 'package:get/get.dart';
import 'package:my_library/controllers/add_screen_controller.dart';
import 'package:my_library/controllers/auth_controller.dart';

import 'package:my_library/controllers/app_root_screen_controller.dart';
import 'package:my_library/controllers/category_detail_screen_controller.dart';

import 'package:my_library/database.dart';

class SampleBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<AppScreenRootController>(() => AppScreenRootController());
    Get.lazyPut<DatabaseController>(() => DatabaseController());
    Get.lazyPut<CategoryDetailScreenController>(
        () => CategoryDetailScreenController());
    // Get.lazyPut<Category>(() => Category());
    Get.lazyPut<AddCardScreenController>(() => AddCardScreenController());
  }
}
