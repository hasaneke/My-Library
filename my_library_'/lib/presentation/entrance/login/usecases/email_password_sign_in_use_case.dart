import 'package:firebase_auth/firebase_auth.dart';

class EmailPasswordSigninUsecase {
  static Future<User?> emailPasswordSignIn(
      {required String email, required String password}) async {
    final usercredentail = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return usercredentail.user;
  }
}
