import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_library/data/models/settings_model/settings_item_model.dart';

abstract class SettingsItemsConstants {
  static List<SettingsItemModel> settingsItemsModels = [
    SettingsItemModel(
        icon: const FaIcon(
          FontAwesomeIcons.font,
          color: Colors.black,
        ),
        title: 'Change Font'),
    SettingsItemModel(
        icon: const FaIcon(
          FontAwesomeIcons.brush,
          color: Colors.green,
        ),
        title: 'Change Theme'),
  ];
}
