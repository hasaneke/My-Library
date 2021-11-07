import 'package:get/get.dart';

class CategoryDetailScreenController extends GetxController {
  RxBool isCatOpened = false.obs;

  toggleCat() => isCatOpened.value = !isCatOpened.value;
}
