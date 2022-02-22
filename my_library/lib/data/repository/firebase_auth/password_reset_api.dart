import 'package:firebase_auth/firebase_auth.dart';

import 'package:my_library/domain/usecases/auth/email_signin_errors_usecase.dart';

class PasswordResetApi {
  static Future<bool> passwordResetRequest({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      return true;
    } on FirebaseAuthException catch (exception) {
      EmailSigninErrorsUsecase.getSnackBarErrorMessage(exception);
      return false;
    }
  }
}
