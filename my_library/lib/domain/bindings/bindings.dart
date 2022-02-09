import 'package:get/get.dart';

import 'package:my_library/presentation/entrance/email_vertification_lobby.dart/controllers/email_lobby_controller.dart';
import 'package:my_library/presentation/entrance/login/controller/login_controller.dart';
import 'package:my_library/presentation/entrance/signup/controllers/signup_controller.dart';
import 'package:my_library/presentation/in_app/components/add_category_dialog/controller/add_category_dialog_controller.dart';

import 'package:my_library/presentation/in_app/tabbar/pages/tabs/all_cards_screen/controller/all_cards_controller.dart';
import 'package:my_library/presentation/in_app/tabbar/pages/tabs/home/controller/home_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<SignupController>(() => SignupController());
    Get.lazyPut<EmailVertificationLobbyController>(
        () => EmailVertificationLobbyController());

    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AllCardsController>(() => AllCardsController());
    Get.lazyPut<AddCategoryDialogController>(
        () => AddCategoryDialogController(),
        fenix: true);
  }
}
