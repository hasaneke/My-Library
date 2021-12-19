import 'package:get/get.dart';
import 'package:my_library/data/repositories/database.dart';
import 'package:my_library/domain/models/category.dart';

class CategoryDetailScreenController extends GetxController {
  Category category;
  RxBool loading = true.obs;
  CategoryDetailScreenController(this.category);

  RxBool isCatOpened = false.obs;
  RxBool editTitle = false.obs;

  toggleCat() => isCatOpened.value = !isCatOpened.value;

  void onPopUpSelected(String item) async {
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

  @override
  void onInit() {
    category.fetchData().then((value) => loading.value = false);
    super.onInit();
  }
}
