import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/core/utils/routers/app_pages.dart';
import 'package:my_library/data/repositories/auth/FirebaseAuthRepositoryImpl.dart';
import 'package:my_library/data/repositories/auth/FirebaseAuthRepositoryImpl.dart';
import 'package:my_library/data/repositories/errors/FirebaseAuthErrors.dart';

class SignUpController extends GetxController {
  var user = Rx<User?>(null);
  Timer? _timer;
  FirebaseAuthRepositoryApi firebaseAuthRepositoryApi =
      FirebaseAuthRepositoryApi();
  RxString email = RxString('');
  RxString password = RxString('');

  TextEditingController textEditingController = TextEditingController();
  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      user.value = await firebaseAuthRepositoryApi
          .signUpWithEmailandPasswordApi(email: email, password: password);
      sendEmailVertification();
      Get.offAllNamed(Routes.HOME);
      _startTimer();
    } on FirebaseAuthException catch (e) {
      FirebaseAuthErrors(e).displayError();
    }
  }

  Future<void> sendEmailVertification() async {
    firebaseAuthRepositoryApi.sendeEmailVertificationApi(user.value);
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      FirebaseAuth.instance.currentUser!.reload();
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        user.value = FirebaseAuth.instance.currentUser;
        timer.cancel();
      } else {}
    });
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
}
