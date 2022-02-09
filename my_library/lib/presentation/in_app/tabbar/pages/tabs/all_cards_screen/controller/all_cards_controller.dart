import 'package:get/get.dart';
import 'package:my_library/data/models/card/my_card.dart';

import 'package:my_library/domain/data/datastore_controller.dart';

class AllCardsController extends GetxController {
  final DatastoreController datastoreController = Get.find();
  late RxMap<String, MyCard> _allCards = RxMap<String, MyCard>({});

  RxMap<String, MyCard> get allCards => _allCards;
  addInAllCards(MyCard myCard) {
    _allCards[myCard.path] = myCard;
  }

  removeFromAllCardslist(MyCard myCard) {
    _allCards.remove(myCard.path);
  }

  @override
  void onInit() {
    DatastoreController datastoreController = Get.find();
    _allCards = datastoreController.allCards;
    super.onInit();
  }
}
