import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/core/utils/consts/settings_items_constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          bottomOpacity: 0,
          foregroundColor: context.theme.iconTheme.color,
          backgroundColor: Get.theme.scaffoldBackgroundColor,
        ),
        body: Column(
          children: SettingsItemsConstants.settingsItemsModels
              .map((item) => ListTile(
                    leading: item.icon,
                    title: Text(
                      item.title,
                      style: const TextStyle(fontSize: 20),
                    ),
                    onTap: () => log('change '),
                  ))
              .toList(),
        ));
  }
}
