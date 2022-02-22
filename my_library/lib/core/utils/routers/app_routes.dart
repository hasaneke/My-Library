// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const LOGIN_SCREEN_ROUTE = _Paths.LOGIN_SCREEN;
  static const SIGN_UP_SCREEN_ROUTE = _Paths.SIGN_UP_SCREEN;
  static const TABBAR_SCREEN_ROUTE = _Paths.TABBAR_SCREEN;
  static const CATEGORY_DETAIL_SCREEN_ROUTE = _Paths.CATEGORY_DETAIL_SCREEN;
  static const SETTINGS_SCREEN_ROUTE = _Paths.SETTINGS_SCREEN;
  static const ADD_CARD_SCREE_ROUTE = _Paths.ADD_CARD_SCREEN;
  static const UPDATE_CARD_SCREEN_ROUTE = _Paths.UPDATE_CARD_SCREE;
  static const CARD_DETAIL_SCREEN_ROUTE = _Paths.CARD_DETAIL_SCREEN;
  static const EMAIL_VERTIFICATION_LOBBY_SCREEN_ROUTE =
      _Paths.EMAIL_VERTIFICATION_LOBBY_SCREEN;
  static const PROFILE_SCREEN = _Paths.PROFILE_SCREEN;
  static const PASSWORD_RESET_SCREEN = _Paths.PASSWORD_RESET_SCREEN;
}

abstract class _Paths {
  static const LOGIN_SCREEN = '/login';
  static const EMAIL_VERTIFICATION_LOBBY_SCREEN =
      '/email-vertification-lobby-screen';
  static const SIGN_UP_SCREEN = '/sign-up';
  static const TABBAR_SCREEN = '/home';
  static const CATEGORY_DETAIL_SCREEN = '/category-detail-screen';
  static const SETTINGS_SCREEN = '/settings-screen';
  static const ADD_CARD_SCREEN = '/add-card-screen';
  static const UPDATE_CARD_SCREE = '/update-card-screen';
  static const CARD_DETAIL_SCREEN = '/card-detail-screen';
  static const PROFILE_SCREEN = '/profile-screen';
  static const PASSWORD_RESET_SCREEN = '/password-reset-screen';
}
