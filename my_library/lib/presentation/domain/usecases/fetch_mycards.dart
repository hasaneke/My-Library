import 'package:get/get.dart';

import 'package:my_library/data/models/card/my_card.dart';
import 'package:my_library/data/repository/firebase_firestore/fetch_mycard_from_firebase.dart';

class FetchMyCards {
  static Future<Map<String, MyCard>> fetchMyCards(String catPath) async {
    try {
      var querySnapshot =
          await FetchMyCardsFromFireStore.fetchMyCardsFromFireStoreApi(catPath);
      Map<String, MyCard> myCards = {};
      for (var doc in querySnapshot!.docs) {
        MyCard newCard = MyCard.docToMyCard(catPath, doc);

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
