import 'package:get/get.dart';
import 'package:my_library/core/utils/routers/app_pages.dart';

import 'package:my_library/data/repository/firebase_auth/signout_api.dart';

class SignOut {
  static signOut() {
    SignoutApi.signOut();
    Get.offAllNamed(Routes.LOGIN_SCREEN_ROUTE);
  }
}
