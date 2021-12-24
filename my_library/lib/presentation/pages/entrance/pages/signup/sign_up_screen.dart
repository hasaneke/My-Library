import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_library/presentation/pages/entrance/pages/signup/sign_up_controller.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey();
    final _passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: context.theme.scaffoldBackgroundColor,
      ),
      body: Center(
        child: Form(
          key: _formKey,
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
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(hintText: 'password'.tr),
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration:
                              InputDecoration(hintText: 'password_again'.tr),
                          onSaved: (value) {
                            controller.password.value = value!;
                          },
                          validator: (value) {
                            if (value != _passwordController.text) {
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
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();
                      controller.signUpWithEmailAndPassword(
                          email: controller.email.value,
                          password: controller.password.value);
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
