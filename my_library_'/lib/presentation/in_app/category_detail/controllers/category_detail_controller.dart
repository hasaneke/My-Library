import 'package:get/get.dart';

class CategoryDetailController extends GetxController {
  RxBool isCatOpened = false.obs;

  toggleCat() {
    isCatOpened.value = !isCatOpened.value;
  }
}
