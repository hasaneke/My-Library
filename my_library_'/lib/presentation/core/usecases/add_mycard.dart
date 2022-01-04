import 'package:get/get.dart';
import 'package:my_library/data/models/card/my_card.dart';
import 'package:my_library/data/models/category/my_category.dart';
import 'package:my_library/data/repository/firestore/add_card_to_firebase.dart';
import 'package:my_library/presentation/in_app/tabbar/pages/tabs/all_cards_screen/controller/all_cards_controller.dart';

class AddCard {
  static Future<void> addMyCard(MyCard myCard) async {
    AddMyCardToFirebase.addMyCardToFirebase(myCard);
    MyCategory containerCategory = Get.find(tag: myCard.containerCatPath);
    AllCardsController allCardsController = Get.find();
    allCardsController.addInAllCardsList(myCard);
    containerCategory.myCards[myCard.path] = myCard;
  }
}
