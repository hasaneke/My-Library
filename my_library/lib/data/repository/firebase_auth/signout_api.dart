import 'package:firebase_auth/firebase_auth.dart';

class SignoutApi {
  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
