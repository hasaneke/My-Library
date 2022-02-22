import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/core/utils/routers/app_pages.dart';
import 'package:my_library/presentation/entrance/login/controller/login_controller.dart';

// ignore: use_key_in_widget_constructors
class LoginScreen extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Obx(() {
          if (controller.isSigningIn.value == false) {
            return SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(flex: 3, child: welcomeWidget()),
                    Expanded(flex: 7, child: AuthWidget()),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(color: Colors.black));
          }
        }));
  }

  Row welcomeWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 25,
          height: 1,
          color: Colors.black,
        ),
        Text(
          'login_intro'.tr,
          style: const TextStyle(fontSize: 27),
        ),
        Container(
          width: 25,
          height: 1,
          color: Colors.black,
        ),
      ],
    );
  }
}

class AuthWidget extends GetView<LoginController> {
  final _focuseNode1 = FocusNode();
  final _focuseNode2 = FocusNode();

  AuthWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.only(top: 25, left: 35, right: 35),
            child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  TextFormField(
                                    focusNode: _focuseNode1,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        hintText: 'email'.tr,
                                        prefixIcon: const Icon(Icons.mail,
                                            color: Colors.black)),
                                    validator: (value) {
                                      if (!value!.contains('@') ||
                                          value.isEmpty) {
                                        Get.showSnackbar(GetSnackBar(
                                          duration: const Duration(seconds: 2),
                                          message: value.isEmpty
                                              ? 'Enter an email'
                                              : 'enter_a_valid_email'.tr,
                                          isDismissible: true,
                                        ));
                                      }
                                      return null;
                                    },
                                    onSaved: (emailText) {
                                      controller.email.value = emailText!;
                                    },
                                  ),
                                  const Divider(),
                                  TextFormField(
                                    focusNode: _focuseNode2,
                                    textInputAction: TextInputAction.done,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: 'password'.tr,
                                      prefixIcon: const Icon(Icons.vpn_key,
                                          color: Colors.black),
                                    ),
                                    onSaved: (passwordText) {
                                      controller.password.value = passwordText!;
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        Get.showSnackbar(GetSnackBar(
                                          duration: const Duration(seconds: 2),
                                          message: 'enter_a_password'.tr,
                                        ));
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'not_registered_yet?'.tr,
                                  style: const TextStyle(fontSize: 15),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.SIGN_UP_SCREEN_ROUTE,
                                        preventDuplicates: true);
                                  },
                                  child: Text('sign_up'.tr,
                                      style: const TextStyle(
                                          color: Colors.purpleAccent,
                                          fontSize: 18)),
                                )
                              ],
                            ),
                            ElevatedButton(
                                style: context.theme.elevatedButtonTheme.style,
                                onPressed: () =>
                                    controller.signInWithEmailAndPassword(),
                                child: Text(
                                  'sign_in'.tr,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 22),
                                )),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 35),
                      child: MaterialButton(
                        height: 60,
                        color: Colors.lime[50],
                        onPressed: () => controller.signInWithGoogle(),
                        elevation: 2.0,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(
                                  0.0, 0.0, 10.0, 0.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)),
                              child: const Image(
                                image: AssetImage('assets/google_light.png'),
                                height: 35,
                              ),
                            ),
                            SizedBox(
                              width: 140,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'sign_in_with_google'.tr,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 200),
                      child: TextButton(
                          onPressed: () {
                            controller.navigateToResetPassword();
                          },
                          child: const Text(
                            'I forgot my password',
                            style: TextStyle(color: Colors.purple),
                          )),
                    )
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
