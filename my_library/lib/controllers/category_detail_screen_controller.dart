import 'package:get/get.dart';

class CategoryDetailScreenController extends GetxController {
  RxBool isCatOpened = false.obs;

  openCat() => isCatOpened.value = !isCatOpened.value;
}
