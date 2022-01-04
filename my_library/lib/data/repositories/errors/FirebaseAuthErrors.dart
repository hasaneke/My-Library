import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseAuthErrors {
  FirebaseAuthException e;
  FirebaseAuthErrors(this.e);

  displayError() {
    if (e.code == 'weak-password') {
      Get.showSnackbar(GetSnackBar(
        title: 'weak_password'.tr,
        message: 'weak_password_message'.tr,
        duration: const Duration(seconds: 1),
      ));
    } else if (e.code == 'email-already-in-use') {
      Get.showSnackbar(GetSnackBar(
        message: 'email_already_in_use'.tr,
        duration: const Duration(seconds: 2),
      ));
    }
  }
}
