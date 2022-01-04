import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:my_library/core/utils/routers/app_pages.dart';
import 'package:my_library/data/repository/auth/signout_usecase.dart';

class MyDrawer extends StatelessWidget {
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
          ListTile(
            leading: const Icon(Icons.settings),
            title:
                Text('settings'.tr, style: context.theme.textTheme.bodyText1),
            onTap: () {
              Get.toNamed(Routes.SETTINGS_SCREEN_ROUTE);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title:
                Text('sign_out'.tr, style: context.theme.textTheme.bodyText1),
            onTap: () {
              SignoutUsecase.signOut();
              Get.offAllNamed(Routes.LOGIN_SCREEN_ROUTE);
            },
          )
        ],
      ),
    );
  }
}
