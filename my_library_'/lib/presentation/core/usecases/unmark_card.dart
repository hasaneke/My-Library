import 'package:get/get.dart';
import 'package:my_library/data/models/card/my_card.dart';
import 'package:my_library/data/repository/firestore/unmark_card_firebase.dart';
import 'package:my_library/presentation/in_app/tabbar/pages/tabs/marked_cards/controllers/marked_cards_controller.dart';

class UnMarkCard {
  static void unMarkCard(MyCard myCard) {
    myCard = Get.find(tag: myCard.path);
    myCard.unMark();
    UnMarkCardFirebaseApi.unMarkCardFirebaseApi(myCard);
    MarkedCardsController markedCardsController = Get.find();
    markedCardsController.removeMyCardFromMarkedCardsList(myCard);
  }
}
