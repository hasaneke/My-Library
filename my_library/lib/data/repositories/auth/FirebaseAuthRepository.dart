import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthRepository {
  Future<User?> signUpWithEmailandPasswordApi(
      {required String email, required String password});
  Future<User> loginWithEmailandPasswordApi();
  Future<User> signInWithGoogleApi();
  Future<void> sendeEmailVertificationApi(User user);
}
