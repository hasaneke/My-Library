import 'package:get/get.dart';
import 'package:my_library/data/models/card/my_card.dart';
import 'package:my_library/data/repository/firebase_firestore/togglemark_mycard_firebase.dart';
import 'package:my_library/presentation/in_app/tabbar/pages/tabs/marked_cards/controllers/marked_cards_controller.dart';

class ToggleMarkCard {
  static void toggleMarkMyCard(MyCard myCard) {
    myCard = Get.find(tag: myCard.path);
    ToggleMyCardFirestoreApi.toggleMarkMyCardFirebaseApi(myCard);
    MarkedCardsController markedCardsController = Get.find();
    if (myCard.isMarked!.value) {
      markedCardsController.addMyCardToMarkedCards(myCard);
    } else {
      markedCardsController.removeMyCardFromMarkedCards(myCard);
    }
  }
}
