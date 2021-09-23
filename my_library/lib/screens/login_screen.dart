import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/controllers/auth_controller.dart';
import 'package:my_library/routes/app_pages.dart';

final _formKey = GlobalKey<FormState>();

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({Key? key}) : super(key: key);

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

class AuthWidget extends GetView<AuthController> {
  final Map<String, String> _authData = {'email': '', 'password': ''};
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
            padding:
                const EdgeInsets.only(top: 25, left: 35, right: 35, bottom: 55),
            child: Form(
                key: _formKey,
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
                                        Get.showSnackbar(GetBar(
                                          duration: const Duration(seconds: 2),
                                          message: value.isEmpty
                                              ? 'Enter an email'
                                              : 'enter_a_valid_email'.tr,
                                          isDismissible: true,
                                        ));
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _authData['email'] = value!;
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
                                    onSaved: (value) {
                                      _authData['password'] = value!;
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        Get.showSnackbar(GetBar(
                                          duration: const Duration(seconds: 2),
                                          message: 'enter_a_password'.tr,
                                        ));
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 25,
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
                                    Get.toNamed(Routes.SIGN_UP,
                                        preventDuplicates: true);
                                  },
                                  child: Text(
                                    'sign_up'.tr,
                                    style: context.theme.textTheme.bodyText1,
                                  ),
                                )
                              ],
                            ),
                            ElevatedButton(
                                style: context.theme.elevatedButtonTheme.style,
                                onPressed: () {
                                  if (!_formKey.currentState!.validate()) {
                                    log('?');
                                    return;
                                  }
                                  _formKey.currentState!.save();
                                  controller.signInWithEmailAndPassword(
                                      _authData['email'],
                                      _authData['password']);
                                },
                                child: Text(
                                  'sign_in'.tr,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 20),
                                )),
                          ],
                        ),
                      ],
                    ),
                    const Divider(),
                    MaterialButton(
                      height: 60,
                      color: Colors.lime[50],
                      onPressed: () {
                        controller.signInWithGoogle();
                      },
                      elevation: 2.0,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
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
                          )
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
