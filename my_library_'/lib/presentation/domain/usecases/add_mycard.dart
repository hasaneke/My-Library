import 'package:get/get.dart';
import 'package:my_library/data/models/card/my_card.dart';
import 'package:my_library/data/models/category/my_category.dart';
import 'package:my_library/data/repository/firebase_firestore/add_card_to_firebase.dart';

class AddCard {
  static Future<void> addMyCard(MyCard myCard) async {
    /* ----------------- */
    AddMyCardToFirebase.addMyCardToFirebase(myCard);
    MyCategory containerCategory = Get.find(tag: myCard.containerCatPath);
    containerCategory.myCards[myCard.path] = myCard;
  }
}
