import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

class SignInGoogleUseCase {
  static Future<User?> googleSignIn() async {
    final credential = await _getCrendetial();
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    var authUser = userCredential.user;
    return authUser;
  }

  static Future<OAuthCredential> _getCrendetial() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return credential;
  }
}
