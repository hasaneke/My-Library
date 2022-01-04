import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_library/presentation/entrance/signup/controllers/signup_controller.dart';

// ignore: use_key_in_widget_constructors
class SignUpScreen extends GetView<SignupController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: context.theme.scaffoldBackgroundColor,
      ),
      body: Center(
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 70),
                  child: Text(
                    'sign_up_intro'.tr,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(hintText: 'email'.tr),
                          validator: (value) {
                            if (!value!.isEmail) {
                              Get.showSnackbar(GetSnackBar(
                                message: 'enter_a_valid_email'.tr,
                                duration: const Duration(seconds: 1),
                              ));
                              return 'invaild email';
                            }
                          },
                          onSaved: (value) {
                            controller.email.value = value!;
                          },
                        ),
                        TextFormField(
                          controller: controller.passwordController,
                          obscureText: true,
                          decoration: InputDecoration(hintText: 'password'.tr),
                          validator: (value) {
                            if (value!.length < 6) {
                              Get.showSnackbar(
                                const GetSnackBar(
                                  message:
                                      'Invaild Password(must be at least 6 charachter long)',
                                  duration: Duration(seconds: 3),
                                ),
                              );
                              return 'invalid password';
                            }
                          },
                          onSaved: (value) {
                            controller.password.value = value!;
                          },
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration:
                              InputDecoration(hintText: 'password_again'.tr),
                          validator: (value) {
                            if (value != controller.passwordController.text) {
                              Get.showSnackbar(GetSnackBar(
                                  message: 'passwords_are_not_matched'.tr,
                                  duration: const Duration(seconds: 1)));
                              return 'error';
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      controller.signUpWithEmailAndPassword();
                    },
                    child: Text('${'sign_up'.tr}!',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20)),
                    style: context.theme.elevatedButtonTheme.style,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
