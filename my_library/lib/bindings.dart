import 'package:get/get.dart';
import 'package:my_library/screens/navigation_screens/add_card/controller/add_card_screen_controller.dart';
import 'package:my_library/screens/navigation_screens/card_detail/card_detail_screen.dart';
import 'package:my_library/screens/navigation_screens/card_detail/controllers/card_detail_screen_controller.dart';
import 'package:my_library/screens/navigation_screens/tab_bar_screens/marked/controller/marked_screen_controller.dart';
import 'package:my_library/screens/presentation_screens/controller/auth_controller.dart';

import 'package:my_library/screens/root/controllers/app_root_screen_controller.dart';
import 'package:my_library/screens/navigation_screens/category_detail/controllers/category_detail_screen_controller.dart';
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
