import 'package:get/get.dart';
import 'package:my_library/core/utils/routers/app_pages.dart';
import 'package:my_library/data/models/category/my_category.dart';

class CategoryDetailController extends GetxController {
  MyCategory myCategory;
  CategoryDetailController({required this.myCategory});
  RxBool isCatOpened = false.obs;

  toggleCat() {
    isCatOpened.value = !isCatOpened.value;
  }

  goToAddCardScreen() {
    Get.toNamed(Routes.ADD_CARD_SCREE_ROUTE, arguments: myCategory.path);
  }
}
