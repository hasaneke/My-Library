import 'package:get/get.dart';
import 'package:my_library/database/database.dart';
import 'package:my_library/models/category.dart';

class CategoryDetailScreenController extends GetxController {
  RxBool isCatOpened = false.obs;
  RxBool editTitle = false.obs;

  toggleCat() => isCatOpened.value = !isCatOpened.value;

  void onPopUpSelected(int item, Category category) async {
    switch (item) {
      case 0:
        editTitle.value = true;
        break;
      case 1:
        final DatabaseController database_controller = Get.find();
        database_controller
            .deleteCategory(category)
            .then((value) => Get.back());
        break;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
