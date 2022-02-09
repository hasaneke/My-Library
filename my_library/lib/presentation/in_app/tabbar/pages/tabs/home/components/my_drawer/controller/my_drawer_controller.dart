import 'package:get/get.dart';
import 'package:my_library/core/utils/routers/app_pages.dart';
import 'package:my_library/domain/usecases/auth/signout.dart';

class MyDrawerController extends GetxController {
  navigate({required String route}) {
    switch (route) {
      case Routes.LOGIN_SCREEN_ROUTE:
        SignOut.signOut();
        break;
      default:
        Get.toNamed(route);
    }
  }
}
