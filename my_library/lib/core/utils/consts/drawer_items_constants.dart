import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_library/core/utils/routers/app_pages.dart';
import 'package:my_library/data/models/drawer/drawer_item.dart';

abstract class DrawerItemsConstants {
  static List<DrawerMenu> drawerItems = [
    DrawerMenu(
        title: 'Profile',
        icon: const FaIcon(FontAwesomeIcons.user),
        route: Routes.PROFILE_SCREEN),
    DrawerMenu(
        title: 'Settings',
        icon: const Icon(Icons.settings),
        route: Routes.SETTINGS_SCREEN_ROUTE),
    DrawerMenu(
        title: 'Sign Out',
        icon: const Icon(Icons.logout),
        route: Routes.LOGIN_SCREEN_ROUTE),
  ];
}
