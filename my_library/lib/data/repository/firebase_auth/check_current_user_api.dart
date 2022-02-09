import 'package:firebase_auth/firebase_auth.dart';

class CheckCurrentUserUseApi {
  static Future<User?> checkCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }
}
