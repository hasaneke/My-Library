import 'package:get/get.dart';
import 'package:my_library/bindings.dart';
import 'package:my_library/controllers/auth_controller.dart';

import 'package:my_library/screens/login_screen.dart';
import 'package:my_library/screens/app_screen_root.dart';
import 'package:my_library/screens/sign_up_screen.dart';

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
        binding: SampleBindings())
  ];
}
