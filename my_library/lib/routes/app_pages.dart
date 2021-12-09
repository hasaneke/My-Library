// ignore_for_file: constant_identifier_names, prefer_const_constructors

import 'package:get/get.dart';
import 'package:my_library/bindings.dart';

import 'package:my_library/screens/drawer_screens/settings_screen.dart';
import 'package:my_library/screens/route_screens/card_detail_screen.dart';

import '../screens/preparation_screens/login_screen.dart';
import 'package:my_library/screens/root/app_screen_root.dart';
import 'package:my_library/screens/route_screens/add_card_screen.dart';
import 'package:my_library/screens/route_screens/category_detail_screen.dart';
import '../screens/preparation_screens/sign_up_screen.dart';

part 'app_routes.dart';

class AppPages extends GetxController {
  AppPages._();
  static const INITIAL = _Paths.LOGIN;

  static final routes = [
    GetPage(
        name: _Paths.LOGIN,
        page: () => LoginScreen(),
        binding: SampleBindings()),
    GetPage(
        name: _Paths.HOME,
        page: () => AppRootScreen(),
        binding: SampleBindings()),
    GetPage(
        name: _Paths.SIGN_UP,
        page: () => SignUpScreen(),
        binding: SampleBindings()),
    GetPage(
        name: _Paths.CATEGORY_DETAIL_SCREEN,
        page: () => CategoryDetailScreen(),
        binding: SampleBindings()),
    GetPage(
        name: _Paths.SETTINGS,
        page: () => SettingsScreen(),
        binding: SampleBindings()),
    GetPage(
        name: _Paths.ADD_CARD_SCREEN,
        page: () => AddCardScreen(),
        binding: SampleBindings()),
    GetPage(
        name: _Paths.CARD_DETAIL_SCREEN,
        page: () => CardDetailScreen(),
        binding: SampleBindings())
  ];
}
