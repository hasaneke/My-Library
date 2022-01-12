import 'package:get/get.dart';
import 'package:my_library/data/models/card/my_card.dart';
import 'package:my_library/data/models/category/my_category.dart';
import 'package:my_library/presentation/domain/data/datastore_controller.dart';

class AllCardsController extends GetxController {
  final DatastoreController datastoreController = Get.find();
  final RxMap<String, MyCard> _allCards = RxMap<String, MyCard>({});

  RxMap<String, MyCard> get allCards => _allCards;
  addInAllCards(MyCard myCard) {
    _allCards[myCard.path] = myCard;
  }

  removeFromAllCardslist(MyCard myCard) {
    _allCards.remove(myCard.path);
  }

  @override
  void onInit() {
    for (var mainCat in datastoreController.maincategories.values) {
      _getAllCards(mainCat);
    }
    super.onInit();
  }

  void _getAllCards(MyCategory myCategory) {
    for (var subCat in myCategory.subCategories.values) {
      _getAllCards(subCat);
    }
    _allCards.addAll(myCategory.myCards);
  }
}
