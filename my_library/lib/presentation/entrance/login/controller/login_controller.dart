import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:my_library/core/utils/routers/app_pages.dart';
import 'package:my_library/data/repository/firebase_auth/check_current_user_usecase.dart';
import 'package:my_library/data/repository/firebase_auth/signed_user.dart';

import 'package:my_library/presentation/entrance/login/usecases/email_password_sign_in_use_case.dart';
import 'package:my_library/presentation/entrance/login/usecases/email_signin_errors_usecase.dart';

import 'package:my_library/presentation/entrance/login/usecases/sign_in_google_usecase.dart';

class LoginController extends GetxController {
  RxString email = RxString(' ');
  RxString password = RxString(' ');
  RxBool isSigningIn = false.obs;
  User? myUser;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> signInWithEmailAndPassword() async {
    try {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
      } else {
        return;
      }
      myUser = await EmailPasswordSigninUsecase.emailPasswordSignIn(
          email: email.value, password: password.value);
      SignedUser.setUser(myUser);
      myUser!.emailVerified
          ? Get.toNamed(Routes.TABBAR_SCREEN_ROUTE)
          : Get.toNamed(Routes.EMAIL_VERTIFICATION_LOBBY_SCREEN_ROUTE);
    } on FirebaseAuthException catch (e) {
      EmailSigninErrorsUsecase.getSnackBarErrorMessage(e);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      isSigningIn.value = true;
      myUser = await SignInGoogleUseCase.googleSignIn().then((founduser) {
        isSigningIn.value = false;
        return founduser;
      });
      SignedUser.setUser(myUser);
      Get.toNamed(Routes.TABBAR_SCREEN_ROUTE);
    } catch (e) {
      isSigningIn.value = false;
      e.printError();
    }
  }

  @override
  void onInit() async {
    isSigningIn.value = true;
    myUser = await CheckCurrentUserUsecase.checkCurrentUser().then((value) {
      isSigningIn.value = false;
      return value;
    });

    if (myUser != null) {
      SignedUser.setUser(myUser);
      myUser!.emailVerified
          ? Get.toNamed(Routes.TABBAR_SCREEN_ROUTE)
          : Get.toNamed(Routes.EMAIL_VERTIFICATION_LOBBY_SCREEN_ROUTE,
              arguments: myUser);
    } else {
      log('no user found');
    }

    super.onInit();
  }
}
