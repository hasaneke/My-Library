import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'controller/tabbar_controller.dart';

// ignore: use_key_in_widget_constructors
class TabbarScreen extends GetView<TabbarController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.value
        ? const Scaffold(
            body: Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ))
        : Scaffold(
            body: controller.pages.elementAt(controller.tabIndex.value),
            bottomNavigationBar: BottomNavigationBar(
                iconSize: 18,
                unselectedIconTheme: context.theme.iconTheme,
                currentIndex: controller.tabIndex.value,
                selectedItemColor: Colors.black,
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
          ));
  }
}
