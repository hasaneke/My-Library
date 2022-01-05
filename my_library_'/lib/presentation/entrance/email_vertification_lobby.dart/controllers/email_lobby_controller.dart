import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_library/core/utils/routers/app_pages.dart';
import 'package:my_library/data/repository/firebase_auth/check_current_user_usecase.dart';
import 'package:my_library/data/repository/firebase_auth/send_email_vertification_usecase.dart';
import 'package:my_library/data/repository/firebase_auth/signout_usecase.dart';

class EmailVertificationLobbyController extends GetxController {
  Timer? _timer;
  Future<void> signOut() async {
    SignoutUsecase.signOut();
    Get.back();
  }

  Future<void> sendEmailVertification() async {
    SendEmailVertificationUsecase.sendEmailVertification();
  }

  _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      FirebaseAuth.instance.currentUser!.reload();
      var user = await CheckCurrentUserUsecase.checkCurrentUser();
      if (user!.emailVerified) {
        Get.toNamed(Routes.TABBAR_SCREEN_ROUTE, arguments: user);
      } else {
        log('waiting for email vertification');
      }
    });
  }

  @override
  void onInit() {
    _startTimer();
    super.onInit();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
}
