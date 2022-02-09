import 'package:firebase_auth/firebase_auth.dart';

class SignedUser {
  static User? myUser;

  static setUser(User? user) {
    myUser = user;
  }
}
