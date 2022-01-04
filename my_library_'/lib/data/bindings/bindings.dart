import 'package:get/get.dart';

import 'package:my_library/presentation/entrance/email_vertification_lobby.dart/controllers/email_lobby_controller.dart';
import 'package:my_library/presentation/entrance/login/controller/login_controller.dart';
import 'package:my_library/presentation/entrance/signup/controllers/signup_controller.dart';
import 'package:my_library/presentation/in_app/add_card/controllers/add_card_controller.dart';
import 'package:my_library/presentation/in_app/card_detail/controller/card_detail_controller.dart';
import 'package:my_library/presentation/in_app/components/add_category_dialog/controller/add_category_dialog_controller.dart';
import 'package:my_library/presentation/in_app/tabbar/controller/tabbar_controller.dart';
import 'package:my_library/presentation/in_app/tabbar/pages/tabs/all_cards_screen/controller/all_cards_controller.dart';
import 'package:my_library/presentation/in_app/tabbar/pages/tabs/home/controller/home_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<SignupController>(() => SignupController());
    Get.lazyPut<EmailVertificationLobbyController>(
        () => EmailVertificationLobbyController());
    Get.lazyPut<TabbarController>(() => TabbarController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AddCategoryDialogController>(
        () => AddCategoryDialogController(),
        fenix: true);
    Get.lazyPut<AllCardsController>(() => AllCardsController());
    Get.lazyPut<AddCardController>(() => AddCardController());
    Get.lazyPut<CardDetailController>(() => CardDetailController());
  }
}
