import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:my_library/core/utils/routers/app_pages.dart';
import 'package:my_library/data/repository/firebase_auth/signed_user.dart';
import 'package:my_library/data/repository/firebase_auth/signup_with_email_and_password_usecase.dart';

class SignupController extends GetxController {
  RxString email = RxString('');
  RxString password = RxString('');
  User? myUser;
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  Timer? _timer;
  Future<void> signUpWithEmailAndPassword() async {
    try {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        myUser =
            await SignupWithEmailAndPasswordUsecase.signupWithEmailAndPassword(
                email: email.value, password: password.value);
        SignedUser.setUser(myUser);
        Get.toNamed(Routes.EMAIL_VERTIFICATION_LOBBY_SCREEN_ROUTE);
      }
    } on FirebaseAuthException catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: e.message,
        duration: const Duration(seconds: 3),
      ));
    }
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
}
