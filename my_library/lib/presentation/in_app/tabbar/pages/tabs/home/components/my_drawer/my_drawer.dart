import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/core/utils/consts/drawer_items_constants.dart';
import 'package:my_library/data/models/drawer/drawer_item.dart';

import 'controller/my_drawer_controller.dart';

class MyDrawer extends GetView<MyDrawerController> {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 20,
                    height: 1,
                    color: Colors.black,
                  ),
                  Text(
                    'my_library'.tr,
                    style: const TextStyle(fontSize: 27),
                  ),
                  Container(
                    width: 20,
                    height: 1,
                    color: Colors.black,
                  ),
                ],
              ))),
          ...DrawerItemsConstants.drawerItems
              .map((item) => drawerItem(drawerItem: item))
              .toList()
        ],
      ),
    );
  }

  ListTile drawerItem({required DrawerMenu drawerItem}) {
    return ListTile(
      leading: drawerItem.icon,
      title: Text(drawerItem.title, style: Get.theme.textTheme.bodyText1),
      onTap: () => controller.navigate(route: drawerItem.route),
    );
  }
}
