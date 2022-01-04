import 'dart:developer';

import 'package:get/get.dart';
import 'package:my_library/data/models/card/my_card.dart';

class MarkedCardsController extends GetxController {
  final RxList<MyCard> _markedCards = RxList<MyCard>([]);
  RxList<MyCard> get markedCards => _markedCards;

  void addMyCardToMarkedCardslist(MyCard myCard) {
    _markedCards.add(myCard);
  }

  void removeMyCardFromMarkedCardsList(MyCard myCard) {
    _markedCards.remove(myCard);
  }

  @override
  void onInit() {
    log('marked controller');
    super.onInit();
  }
}
