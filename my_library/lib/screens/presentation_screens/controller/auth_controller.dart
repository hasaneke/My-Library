import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_library/utils/routers/app_pages.dart';

class AuthController extends GetxController {
  var user = Rx<User?>(null);
  Timer? _timer;
  RxBool isSigningIn = false.obs;
  /* EMAIL AND PASSWORD SIGN UP */
  UserCredential? userCredential;
  Future<void> signUpWithEmailAndPassword(
      String? email, String? password) async {
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      if (userCredential!.user != null) {
        user.value = userCredential!.user!;
        Get.offAllNamed(Routes.HOME);
        startTimer();
        userCredential!.user!.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.showSnackbar(GetSnackBar(
          title: 'weak_password'.tr,
          message: 'weak_password_message'.tr,
          duration: const Duration(seconds: 1),
        ));
      } else if (e.code == 'email-already-in-use') {
        Get.showSnackbar(GetSnackBar(
          message: 'email_already_in_use'.tr,
          duration: const Duration(seconds: 2),
        ));
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: e.toString(),
        duration: const Duration(seconds: 1),
      ));
    }
  }

  /* EMAIL AND PASSWORD SIGN IN */
  Future<void> signInWithEmailAndPassword(
      String? email, String? password) async {
    try {
      isSigningIn.value = true;
      user.value = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!)
          .then((value) {
        return value.user;
      });
      sendEmailVertification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.showSnackbar(GetSnackBar(
          duration: const Duration(seconds: 2),
          message: 'No users found for that email',
        ));
      } else if (e.code == 'wrong-password') {
        Get.showSnackbar(GetSnackBar(
          duration: const Duration(seconds: 2),
          message: 'Wrong password or email',
        ));
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: e.toString(),
        duration: Duration(seconds: 3),
      ));
    }
  }

  /* GOOGLE SIGN IN*/
  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    isSigningIn.value = true;
    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      user.value = value.user;
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAllNamed(Routes.HOME);
      });
      if (!FirebaseAuth.instance.currentUser!.emailVerified) {
        startTimer();
      }
    });
  }

  /* ORDINARY SIGN OUT PROCESS */
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut().then((value) {
      user.value = null;
      isSigningIn.value = false;
      if (_timer != null) {
        _timer!.cancel();
      }
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAllNamed(Routes.LOGIN);
      });
    });
  }

  Future<void> sendEmailVertification() async {
    user.value!.sendEmailVerification();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      FirebaseAuth.instance.currentUser!.reload();
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        log('email verified');
        user.value = FirebaseAuth.instance.currentUser;
        timer.cancel();
      } else {
        log('waiting for vertification');
      }
    });
  }

  @override
  void onInit() async {
    if (FirebaseAuth.instance.currentUser != null) {
      user.value =
          FirebaseAuth.instance.currentUser; // USER HAS BEEN INITIALIZED

    } else {
      user.value = null;
    }
    if (user.value != null && !user.value!.emailVerified) {
      startTimer();
    }
    super.onInit();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }
}
