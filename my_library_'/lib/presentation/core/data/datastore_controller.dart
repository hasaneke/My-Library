import 'package:get/get.dart';
import 'package:my_library/data/models/card/my_card.dart';

import 'package:my_library/data/models/category/my_category.dart';

import 'package:my_library/core/utils/consts/pathtosave.dart';
import 'package:my_library/presentation/core/usecases/fetch_categories.dart';
import 'package:my_library/presentation/in_app/tabbar/pages/tabs/all_cards_screen/controller/all_cards_controller.dart';
import 'package:my_library/presentation/in_app/tabbar/pages/tabs/marked_cards/controllers/marked_cards_controller.dart';

class DatastoreController extends GetxController {
  final RxMap<String, MyCategory> _maincategories =
      RxMap<String, MyCategory>({});
  final RxMap<String, MyCard> _favoriteCards = RxMap<String, MyCard>({});
  final RxMap<String, MyCard> _allCards = RxMap<String, MyCard>({});

  RxMap<String, MyCategory> get maincategories => _maincategories;
  RxMap<String, MyCard> get favoriteCards => _favoriteCards;
  RxMap<String, MyCard> get allCards => _allCards;

  addMainCategory(MyCategory myCategory) {
    _maincategories[myCategory.path] = myCategory;
  }

  deleteMainCategory(MyCategory myCategory) {
    _maincategories.remove(myCategory.path);
  }

  @override
  void onInit() async {
    Get.put(AllCardsController());
    Get.put(MarkedCardsController());
    _maincategories.value =
        await FetchCategories.fetchMainCategories(PathToSave.getMainPath);

    super.onInit();
  }
}
