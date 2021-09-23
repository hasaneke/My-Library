part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const LOGIN = _Paths.LOGIN;
  static const SIGN_UP = _Paths.SIGN_UP;
  static const HOME = _Paths.HOME;
  static const CATEGORY_DETAIL = _Paths.CATEGORY_DETAIL;
  static const SETTINGS = '/settings-screen';
}

abstract class _Paths {
  static const LOGIN = '/login';
  static const SIGN_UP = '/sign-up';
  static const HOME = '/home';
  static const CATEGORY_DETAIL = '/category-detail-screen';
  static const SETTINGS = '/settings-screen';
}
