import 'package:get/get.dart';
import 'package:my_library/data/models/card/my_card.dart';
import 'package:my_library/data/models/category/my_category.dart';

import 'package:my_library/data/repository/firebase_firestore/delete_mycard_from_firebase.dart';
import 'package:my_library/presentation/in_app/tabbar/pages/tabs/all_cards_screen/controller/all_cards_controller.dart';
import 'package:my_library/presentation/in_app/tabbar/pages/tabs/marked_cards/controllers/marked_cards_controller.dart';

class DeleteMyCard {
  // static Future<void> deleteMyCard(MyCard myCard) async {
  //   DeleteMyCardFromFirebaseApi.deleteMyCardFromFirebaseApi(myCard.path);
  //   try {
  //     MyCategory myCategory = Get.find(tag: myCard.containerCatPath);
  //     myCategory.myCards.remove(myCard.path);
  //   } catch (e) {
  //     Get.showSnackbar(GetSnackBar(
  //       message: e.toString(),
  //       duration: const Duration(seconds: 3),
  //     ));
  //   }
  // }

  static Future<void> deleteMyCard(MyCard myCard) async {
    DeleteMyCardFromFirebaseApi.deleteMyCardFromFirebaseApi(myCard.path);
    AllCardsController allCardsController = Get.find();
    MarkedCardsController markedCardsController = Get.find();
    try {
      MyCategory myCategory = Get.find(tag: myCard.containerCatPath);
      myCategory.myCards.remove(myCard.path);
      allCardsController.removeFromAllCardslist(myCard);
      if (myCard.isMarked!.value) {
        markedCardsController.removeMyCardFromMarkedCardsList(myCard);
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: e.toString(),
        duration: const Duration(seconds: 3),
      ));
    }
  }
}
