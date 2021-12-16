import 'package:get/get.dart';
import 'package:my_library/data/repositories/database.dart';
import 'package:my_library/data/models/category/category.dart';

class CategoryDetailScreenController extends GetxController {
  RxBool isCatOpened = false.obs;
  RxBool editTitle = false.obs;

  toggleCat() => isCatOpened.value = !isCatOpened.value;

  void onPopUpSelected(String item, Category category) async {
    switch (item) {
      case 'edit':
        editTitle.value = true;
        break;
      case 'delete':
        category.delete();
        Get.back();
        break;
    }
  }
}
