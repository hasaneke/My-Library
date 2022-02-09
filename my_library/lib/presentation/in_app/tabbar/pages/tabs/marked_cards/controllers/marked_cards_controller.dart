import 'package:get/get.dart';
import 'package:my_library/data/models/card/my_card.dart';
import 'package:my_library/domain/data/datastore_controller.dart';

class MarkedCardsController extends GetxController {
  final RxMap<String, MyCard> _markedCards = RxMap<String, MyCard>({});
  RxMap<String, MyCard> get markedCards => _markedCards;

  void addMyCardToMarkedCards(MyCard myCard) {
    _markedCards[myCard.path] = myCard;
  }

  void removeMyCardFromMarkedCards(MyCard myCard) {
    _markedCards.remove(myCard.path);
  }

  @override
  void onInit() {
    DatastoreController datastoreController = Get.find();
    for (var card in datastoreController.allCards.values) {
      if (card.isMarked!.value) {
        _markedCards[card.path] = card;
      }
    }

    super.onInit();
  }
}
