import 'package:get/get.dart';
import 'package:my_library/controllers/auth_controller.dart';
import 'package:my_library/controllers/category_controller.dart';
import 'package:my_library/controllers/app_root_screen_controller.dart';

class SampleBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<CategoryController>(() => CategoryController());
    Get.lazyPut<AppScreenRootController>(() => AppScreenRootController());
  }
}
