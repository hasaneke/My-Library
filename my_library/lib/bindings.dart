import 'package:get/get.dart';
import 'package:my_library/presentation/pages/entrance/pages/signup/sign_up_controller.dart';

import 'package:my_library/presentation/pages/home/pages/add_card/controller/add_card_screen_controller.dart';

import 'package:my_library/presentation/pages/entrance/controller/auth_controller.dart';

import 'package:my_library/presentation/pages/home/controllers/home_screen_controller.dart';

import 'package:my_library/data/repositories/database.dart';

import 'presentation/pages/home/pages/card_detail/controllers/card_detail_screen_controller.dart';
import 'presentation/pages/home/pages/tab_bar/marked/controller/marked_screen_controller.dart';

class MyLibraryBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<AppScreenRootController>(() => AppScreenRootController());
    Get.lazyPut<DatabaseController>(() => DatabaseController());
    Get.lazyPut<AddCardScreenController>(() => AddCardScreenController());
    Get.lazyPut<CardDetailScreenController>(() => CardDetailScreenController());
    Get.lazyPut<MarkedScreenController>(() => MarkedScreenController());
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}
