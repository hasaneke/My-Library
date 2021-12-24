// ignore_for_file: constant_identifier_names, prefer_const_constructors

import 'package:get/get.dart';
import 'package:my_library/bindings.dart';

import 'package:my_library/presentation/pages/entrance/pages/login/login_screen.dart';
import 'package:my_library/presentation/pages/entrance/pages/signup/sign_up_screen.dart';

import 'package:my_library/presentation/pages/home/pages/add_card/page/add_card_screen.dart';

import 'package:my_library/presentation/pages/home/pages/app_screen_root.dart';

import 'package:my_library/presentation/pages/home/pages/card_detail/card_detail_screen.dart';
import 'package:my_library/presentation/pages/home/pages/category_detail/pages/category_detail_screen.dart';
import 'package:my_library/presentation/pages/home/pages/drawer/settings_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = _Paths.LOGIN;

  static final routes = [
    GetPage(
        name: _Paths.LOGIN,
        page: () => LoginScreen(),
        binding: MyLibraryBindings()),
    GetPage(
        name: _Paths.HOME,
        page: () => AppRootScreen(),
        binding: MyLibraryBindings()),
    GetPage(
        name: _Paths.SIGN_UP,
        page: () => SignUpScreen(),
        binding: MyLibraryBindings()),
    GetPage(
        name: _Paths.CATEGORY_DETAIL_SCREEN,
        page: () => CategoryDetailScreen(),
        binding: MyLibraryBindings()),
    GetPage(
        name: _Paths.SETTINGS,
        page: () => SettingsScreen(),
        binding: MyLibraryBindings()),
    GetPage(
        name: _Paths.ADD_CARD_SCREEN,
        page: () => AddCardScreen(),
        binding: MyLibraryBindings()),
    GetPage(
        name: _Paths.CARD_DETAIL_SCREEN,
        page: () => CardDetailScreen(),
        binding: MyLibraryBindings())
  ];
}
