import 'package:firebase_auth/firebase_auth.dart';

class SignedUser {
  static User? _myUser;

  static setUser(User? user) {
    _myUser = user;
  }

  static User? getUser() {
    return _myUser;
  }
}
