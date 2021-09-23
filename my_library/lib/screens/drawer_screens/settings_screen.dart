import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          settingsItem('Change Theme', Icons.palette, context),
          settingsItem('Change font style', Icons.font_download, context),
        ],
      ),
    );
  }

  Padding settingsItem(String title, IconData iconData, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: context.theme.scaffoldBackgroundColor,
            child: Icon(
              iconData,
              color: Colors.black,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }
}
