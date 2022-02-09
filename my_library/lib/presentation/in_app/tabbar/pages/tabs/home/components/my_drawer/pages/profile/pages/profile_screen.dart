import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/data/repository/firebase_auth/signed_user.dart';
import 'package:my_library/presentation/in_app/tabbar/pages/tabs/home/components/my_drawer/pages/profile/controller/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = controller.getUser;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottomOpacity: 0,
        foregroundColor: context.theme.iconTheme.color,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Center(
                  child: CircleAvatar(
                backgroundImage: NetworkImage(user.photoURL!),
                radius: 40,
              )),
              const SizedBox(
                height: 8,
              ),
              Text(
                user.email!,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
          Container(
              padding: const EdgeInsets.only(bottom: 20, left: 250),
              child: TextButton(
                  onPressed: controller.changePassword,
                  child: const Text(
                    'Change Password',
                    style: TextStyle(color: Colors.purple, fontSize: 18),
                  ))),
        ],
      ),
    );
  }
}
