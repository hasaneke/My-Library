import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_library/presentation/pages/entrance/controller/auth_controller.dart';

import 'package:my_library/presentation/pages/entrance/pages/email_vertification/email_vertifcation_lobby_screen.dart';
import 'package:my_library/presentation/pages/entrance/pages/signout/exit_screen.dart';

import 'package:my_library/presentation/pages/home/controllers/home_screen_controller.dart';
import 'package:get/get.dart';

import 'package:my_library/data/repositories/database.dart';

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
                iconSize: 18,
                unselectedIconTheme: context.theme.iconTheme,
                elevation: 0,
                selectedLabelStyle: const TextStyle(fontSize: 15),
                currentIndex: controller.selectedTabIndex.value,
                selectedItemColor: context.theme.selectedRowColor,
                onTap: (index) => controller.changeTab(index),
                backgroundColor: context.theme.scaffoldBackgroundColor,
                unselectedLabelStyle: TextStyle(fontSize: 12),
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        color: context.theme.iconTheme.color,
                      ),
                      label: 'home_tab'.tr),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.bookmark,
                        color: context.theme.iconTheme.color,
                      ),
                      label: 'marked_tab'.tr),
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
