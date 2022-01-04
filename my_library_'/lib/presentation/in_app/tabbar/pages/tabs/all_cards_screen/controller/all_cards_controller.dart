import 'dart:developer';

import 'package:get/get.dart';
import 'package:my_library/data/models/card/my_card.dart';

class AllCardsController extends GetxController {
  final RxList<MyCard> _allCards = RxList<MyCard>([]);
  RxList<MyCard> get allCards => _allCards;

  addInAllCardsList(MyCard myCard) {
    _allCards.add(myCard);
  }

  removeFromAllCardslist(MyCard myCard) {
    _allCards.remove(myCard);
  }

  @override
  void onInit() {
    log('all cards initialized');
    super.onInit();
  }
}
