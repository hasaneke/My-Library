import 'package:get/get.dart';
import 'package:my_library/database.dart';
import 'package:my_library/models/category.dart';

class CategoryDetailScreenController extends GetxController {
  late RxString path;

  CategoryDetailScreenController({path});

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
        database_controller.deleteCategory(category);
        break;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
