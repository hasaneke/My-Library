// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const LOGIN = _Paths.LOGIN;
  static const SIGN_UP = _Paths.SIGN_UP;
  static const HOME = _Paths.HOME;
  static const CATEGORY_DETAIL = _Paths.CATEGORY_DETAIL;
  static const SETTINGS = _Paths.SETTINGS;
  static const ADDITEM = _Paths.ADDITEM;
}

abstract class _Paths {
  static const LOGIN = '/login';
  static const SIGN_UP = '/sign-up';
  static const HOME = '/home';
  static const CATEGORY_DETAIL = '/category-detail-screen';
  static const SETTINGS = '/settings-screen';
  static const ADDITEM = '/add-item-screen';
}
