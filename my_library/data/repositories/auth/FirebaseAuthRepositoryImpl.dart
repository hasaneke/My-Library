import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_library/data/repositories/auth/FirebaseAuthRepository.dart';
import 'package:my_library/data/repositories/errors/FirebaseAuthErrors.dart';

class FirebaseAuthRepositoryApi extends FirebaseAuthRepository {
  @override
  Future<User?> signUpWithEmailandPasswordApi(
      {required String email, required String password}) async {
    UserCredential userCredential;

    userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    userCredential.user!.sendEmailVerification();
    return userCredential.user;
  }

  @override
  Future<User> loginWithEmailandPasswordApi() async {
    throw UnimplementedError();
  }

  @override
  Future<void> sendeEmailVertificationApi(User? user) {
    user!.sendEmailVerification();
    throw UnimplementedError();
  }

  @override
  Future<User> signInWithGoogleApi() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }
}
