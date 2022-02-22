import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/domain/usecases/auth/passowrd_reset_usecase.dart';
import 'package:email_validator/email_validator.dart';

class PasswordResetController extends GetxController {
  late TextEditingController textController;

  @override
  void onInit() {
    textController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  sendPasswordResetRequest() {
    if (EmailValidator.validate(textController.text)) {
      PasswordReset.resetPassword(email: textController.text);
    } else {
      Get.showSnackbar(const GetSnackBar(
        message: 'Please enter a valid email',
        duration: Duration(seconds: 2),
      ));
    }
  }
}
