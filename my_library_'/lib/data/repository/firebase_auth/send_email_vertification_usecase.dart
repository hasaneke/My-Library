import 'package:firebase_auth/firebase_auth.dart';

class SendEmailVertificationUsecase {
  static Future<void> sendEmailVertification() async {
    FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }
}
