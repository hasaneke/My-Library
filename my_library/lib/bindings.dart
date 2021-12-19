import 'package:get/get.dart';
import 'package:my_library/presentation/home/add_card/controller/add_card_screen_controller.dart';
import 'package:my_library/presentation/home/card_detail/card_detail_screen.dart';
import 'package:my_library/presentation/home/card_detail/controllers/card_detail_screen_controller.dart';
import 'package:my_library/presentation/home/tab_bar_screens/marked/controller/marked_screen_controller.dart';
import 'package:my_library/presentation/presentation_screens/controller/auth_controller.dart';

import 'package:my_library/presentation/root/controllers/app_root_screen_controller.dart';
import 'package:my_library/presentation/home/category_detail/controllers/category_detail_screen_controller.dart';
import 'package:my_library/data/repositories/database.dart';

class MyLibraryBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<AppScreenRootController>(() => AppScreenRootController());
    Get.lazyPut<DatabaseController>(() => DatabaseController());
    Get.lazyPut<AddCardScreenController>(() => AddCardScreenController());
    Get.lazyPut<CardDetailScreenController>(() => CardDetailScreenController());
    Get.lazyPut<MarkedScreenController>(() => MarkedScreenController());
  }
}
