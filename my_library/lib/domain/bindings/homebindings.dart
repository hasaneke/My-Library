import 'package:get/get.dart';
import 'package:my_library/domain/data/datastore_controller.dart';
import 'package:my_library/presentation/in_app/add_card/controllers/add_card_controller.dart';
import 'package:my_library/presentation/in_app/components/add_category_dialog/controller/add_category_dialog_controller.dart';
import 'package:my_library/presentation/in_app/tabbar/controller/tabbar_controller.dart';
import 'package:my_library/presentation/in_app/tabbar/pages/tabs/all_cards_screen/controller/all_cards_controller.dart';
import 'package:my_library/presentation/in_app/tabbar/pages/tabs/home/components/my_drawer/controller/my_drawer_controller.dart';
import 'package:my_library/presentation/in_app/tabbar/pages/tabs/home/components/my_drawer/pages/profile/controller/profile_controller.dart';

import 'package:my_library/presentation/in_app/tabbar/pages/tabs/home/controller/home_controller.dart';

import 'package:my_library/presentation/in_app/tabbar/pages/tabs/marked_cards/controllers/marked_cards_controller.dart';
import 'package:my_library/presentation/in_app/update_card/controller/update_card_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(DatastoreController());
    Get.put(TabbarController());
    Get.lazyPut(() => AllCardsController());
    Get.lazyPut(() => MarkedCardsController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AddCategoryDialogController>(
        () => AddCategoryDialogController(),
        fenix: true);
    Get.lazyPut<AddCardController>(() => AddCardController());
    Get.lazyPut<UpdateCardController>(() => UpdateCardController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<MyDrawerController>(() => MyDrawerController());
  }
}
