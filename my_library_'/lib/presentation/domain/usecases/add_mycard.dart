import 'dart:io';

import 'package:get/get.dart';
import 'package:my_library/data/models/card/my_card.dart';
import 'package:my_library/data/models/category/my_category.dart';
import 'package:my_library/data/repository/firebase_firestore/add_card_to_firebase.dart';

class AddCard {
  static Future<void> addMyCard(MyCard myCard, List<File> files) async {
    AddMyCardToFirebase.addMyCardToFirebase(myCard);
    MyCategory containerCategory = Get.find(tag: myCard.containerCatPath);
    // AllCardsController allCardsController = Get.find();
    // allCardsController.addInAllCardsList(myCard);
    containerCategory.myCards[myCard.path] = myCard;
  }

  // static Future<void> addMyCard(MyCard myCard, List<File> files) async {
  //   /* FILE OPERATION */
  //   for (var file in files) {
  //     if (file.path.split(".").last == "jpg") {
  //       String uniquePathForAFile =
  //           myCard.path + "/imageFiles/" + const Uuid().v1();
  //       myCard.imageFiles![uniquePathForAFile] = file;
  //     } else {
  //       String uniquePathForAFile =
  //           myCard.path + "/otherFiles/" + const Uuid().v1();
  //       myCard.otherFiles![uniquePathForAFile] = file;
  //     }
  //   }
  //   /* ----------------- */
  //   AddMyCardToFirebase.addMyCardToFirebase(myCard);
  //   MyCategory containerCategory = Get.find(tag: myCard.containerCatPath);

  //   AllCardsController allCardsController = Get.find();
  //   allCardsController.addInAllCardsList(myCard);
  //   containerCategory.myCards[myCard.path] = myCard;
  // }
}
