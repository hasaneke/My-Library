import 'package:get/get.dart';
import 'package:my_library/data/models/card/my_card.dart';
import 'package:my_library/presentation/in_app/tabbar/pages/tabs/all_cards_screen/controller/all_cards_controller.dart';

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
    AllCardsController allCardsController = Get.find();
    for (var element in allCardsController.allCards.values) {
      if (element.isMarked!.value) {
        _markedCards[element.path] = element;
      }
    }

    super.onInit();
  }
}
