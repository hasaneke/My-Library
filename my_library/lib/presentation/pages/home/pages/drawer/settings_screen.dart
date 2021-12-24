import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

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
          SettingsItem(
            title: 'Change Theme',
            iconData: Icons.palette,
          ),
          SettingsItem(
              title: 'Change font style', iconData: Icons.font_download)
        ],
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  String? title;
  IconData? iconData;
  Widget? widget;
  SettingsItem({@required this.title, @required this.iconData, this.widget});
  var isOpened = false.obs;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                ListTile(
                  onTap: () => isOpened.value = !isOpened.value,
                  leading: CircleAvatar(
                    backgroundColor: context.theme.scaffoldBackgroundColor,
                    child: Icon(
                      iconData,
                      color: Colors.black,
                    ),
                  ),
                  title: Text(
                    title!,
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
                widget != null
                    ? Obx(() => isOpened.value ? widget! : Container())
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
