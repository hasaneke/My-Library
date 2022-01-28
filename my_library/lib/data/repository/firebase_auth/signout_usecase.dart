import 'package:firebase_auth/firebase_auth.dart';

class SignoutUsecase {
  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
