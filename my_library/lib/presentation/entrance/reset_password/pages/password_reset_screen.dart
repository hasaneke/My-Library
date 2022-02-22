import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/presentation/entrance/reset_password/controller/password_reset_controller.dart';

class PasswordResetScreen extends GetView<PasswordResetController> {
  const PasswordResetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Container(
        padding: const EdgeInsets.all(15),
        height: Get.size.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Login Help',
                style: TextStyle(
                    color: context.textTheme.bodyText1!.color, fontSize: 25),
              ),
            ),
            Column(
              children: const [
                Text(
                  'Find your account',
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 15,
                ),
                Text('Enter your email linked to your account'),
              ],
            ),
            Column(
              children: [
                TextField(
                  controller: controller.textController,
                  decoration: InputDecoration(
                    hintText: 'email'.tr,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () {
                      controller.sendPasswordResetRequest();
                    },
                    child: Text(
                      'Send password reset request',
                      style: TextStyle(
                          color: Get.theme.textTheme.bodyText1!.color),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
