import 'package:get/get.dart';
import 'package:my_library/data/repository/firebase_auth/password_reset_api.dart';

class PasswordReset {
  static Future<void> resetPassword({required String email}) async {
    try {
      if (await PasswordResetApi.passwordResetRequest(email: email)) {
        Get.showSnackbar(const GetSnackBar(
          message: 'Password reset request is sent',
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: e.toString(),
        duration: const Duration(seconds: 2),
      ));
    }
  }
}
