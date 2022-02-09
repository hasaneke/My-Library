import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_library/data/repository/firebase_auth/signed_user.dart';

class ProfileController extends GetxController {
  final User? _signedUser = SignedUser.myUser;
  User get getUser => _signedUser!;
  changePassword() {
    log('Change password');
  }
}
