import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_library/data/repository/firebase_auth/signed_user.dart';

class SignupWithEmailAndPasswordApi {
  static Future<User?> signupWithEmailAndPassword(
      {required String email, required String password}) async {
    var userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    SignedUser.setUser(userCredential.user);
    return userCredential.user;
  }
}
