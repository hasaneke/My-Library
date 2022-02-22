// ignore_for_file: constant_identifier_names, prefer_const_constructors

import 'package:get/get.dart';
import 'package:my_library/domain/bindings/initialibindings.dart';
import 'package:my_library/domain/bindings/homebindings.dart';
import 'package:my_library/presentation/entrance/email_vertification_lobby.dart/pages/email_vertification_lobby_screen.dart';
import 'package:my_library/presentation/entrance/login/pages/login_screen.dart';
import 'package:my_library/presentation/entrance/reset_password/pages/password_reset_screen.dart';
import 'package:my_library/presentation/entrance/signup/pages/sign_up_screen.dart';
import 'package:my_library/presentation/in_app/add_card/pages/add_card_screen.dart';
import 'package:my_library/presentation/in_app/card_detail/pages/card_detail_screen.dart';

import 'package:my_library/presentation/in_app/category_detail/pages/category_detail_screen/category_detail_screen.dart';
import 'package:my_library/presentation/in_app/tabbar/pages/tabs/home/components/my_drawer/pages/profile/pages/profile_screen.dart';
import 'package:my_library/presentation/in_app/tabbar/pages/tabs/home/components/my_drawer/pages/settings/settings_screen.dart';

import 'package:my_library/presentation/in_app/tabbar/tabbar_screen.dart';
import 'package:my_library/presentation/in_app/update_card/pages/update_card_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.LOGIN_SCREEN_ROUTE;

  static final routes = [
    GetPage(
        name: Routes.LOGIN_SCREEN_ROUTE,
        page: () => LoginScreen(),
        binding: InitialBindings()),
    GetPage(
        name: Routes.SIGN_UP_SCREEN_ROUTE,
        page: () => SignUpScreen(),
        binding: InitialBindings()),
    GetPage(
        name: Routes.EMAIL_VERTIFICATION_LOBBY_SCREEN_ROUTE,
        page: () => EmailVertificationLobbyScreen(),
        binding: InitialBindings()),
    GetPage(
        name: Routes.PASSWORD_RESET_SCREEN,
        page: () => PasswordResetScreen(),
        binding: InitialBindings()),
    GetPage(
        name: Routes.TABBAR_SCREEN_ROUTE,
        page: () => TabbarScreen(),
        binding: HomeBindings()),
    GetPage(
        name: Routes.CATEGORY_DETAIL_SCREEN_ROUTE,
        page: () => CategoryDetailScreen(),
        binding: HomeBindings()),
    GetPage(
      name: Routes.ADD_CARD_SCREE_ROUTE,
      page: () => AddCardScreen(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: Routes.CARD_DETAIL_SCREEN_ROUTE,
      page: () => CardDetailScreen(),
      binding: HomeBindings(),
    ),
    GetPage(
        name: Routes.UPDATE_CARD_SCREEN_ROUTE,
        page: () => UpdateCardScreen(),
        binding: HomeBindings()),
    GetPage(
        name: Routes.PROFILE_SCREEN,
        page: () => ProfileScreen(),
        binding: HomeBindings()),
    GetPage(
        name: Routes.SETTINGS_SCREEN_ROUTE,
        page: () => SettingsScreen(),
        binding: HomeBindings()),
  ];
}
