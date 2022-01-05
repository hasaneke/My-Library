import 'package:get/get.dart';
import 'package:my_library/data/models/card/my_card.dart';
import 'package:my_library/data/repository/firebase_firestore/fetch_mycard_from_firebase.dart';
import 'package:my_library/presentation/in_app/tabbar/pages/tabs/all_cards_screen/controller/all_cards_controller.dart';
import 'package:my_library/presentation/in_app/tabbar/pages/tabs/marked_cards/controllers/marked_cards_controller.dart';

class FetchMyCards {
  static Future<Map<String, MyCard>> fetchMyCards(String catPath) async {
    AllCardsController allCardsController = Get.find();
    MarkedCardsController markedCardsController = Get.find();
    try {
      var querySnapshot =
          await FetchMyCardsFromFirebase.fetchMyCardsFromFirebaseApi(catPath);
      Map<String, MyCard> myCards = {};
      for (var doc in querySnapshot!.docs) {
        MyCard newCard = MyCard.docToMyCard(catPath, doc);
        allCardsController.addInAllCardsList(newCard);
        if (newCard.isMarked!.value) {
          markedCardsController.addMyCardToMarkedCardslist(newCard);
        }
        myCards[newCard.path] = newCard;
      }
      return myCards;
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: e.toString(),
        duration: const Duration(seconds: 2),
      ));
      return {};
    }
  }
}
