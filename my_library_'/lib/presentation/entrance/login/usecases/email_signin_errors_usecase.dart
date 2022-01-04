import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class EmailSigninErrorsUsecase {
  static getSnackBarErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'wrong-password':
        Get.showSnackbar(const GetSnackBar(
          message: "Wrong Password",
          duration: Duration(seconds: 3),
        ));
        break;
      case 'user-not-found':
        Get.showSnackbar(const GetSnackBar(
          message: "No user with this email",
          duration: Duration(seconds: 3),
        ));
        break;
      case 'too-many-requests':
        Get.showSnackbar(const GetSnackBar(
          message: 'Too many request',
          duration: Duration(seconds: 3),
        ));
        break;
    }
  }
}
