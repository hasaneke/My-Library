import 'package:get/get.dart';

class CardDetailScreenController extends GetxController {
  RxBool isImageClicked = false.obs;

  displayImage() {
    isImageClicked.value = true;
  }

  undisplayImage() {
    isImageClicked.value = false;
  }
}
