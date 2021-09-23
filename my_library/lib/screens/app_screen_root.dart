import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:my_library/controllers/auth_controller.dart';
import 'package:my_library/controllers/app_root_screen_controller.dart';
import 'package:get/get.dart';
import 'package:my_library/screens/email_vertifcation_lobby_screen.dart';
import 'package:my_library/screens/exit_screen.dart';

import '../database.dart';

class AppRootScreen extends GetView<AppScreenRootController> {
  AppRootScreen({Key? key}) : super(key: key);
  final authController = Get.put(AuthController());
  final databaseController = Get.put(DatabaseController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (authController.user.value != null) {
        if (!authController.user.value!.emailVerified) {
          return const EmailVertificationLobbyScreen();
        } else {
          return Scaffold(
            body: controller.pages[controller.selectedTabIndex.value],
            backgroundColor: context.theme.scaffoldBackgroundColor,
            bottomNavigationBar: BottomNavigationBar(
                unselectedIconTheme: context.theme.iconTheme,
                elevation: 0,
                selectedLabelStyle: const TextStyle(fontSize: 17),
                currentIndex: controller.selectedTabIndex.value,
                selectedItemColor: context.theme.selectedRowColor,
                onTap: (index) => controller.changeTab(index),
                backgroundColor: context.theme.scaffoldBackgroundColor,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        color: context.theme.iconTheme.color,
                      ),
                      label: 'home_tab'.tr),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.favorite,
                        color: context.theme.iconTheme.color,
                      ),
                      label: 'favorites_tab'.tr),
                  BottomNavigationBarItem(
                      icon: FaIcon(
                        FontAwesomeIcons.list,
                        color: context.theme.iconTheme.color,
                      ),
                      label: 'all_cards_tab'.tr)
                ]),
          );
        }
      } else {
        return const ExitScreen();
      }
    });
  }
}
