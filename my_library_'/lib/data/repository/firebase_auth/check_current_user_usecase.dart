import 'package:firebase_auth/firebase_auth.dart';

class CheckCurrentUserUsecase {
  static Future<User?> checkCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }
}
