import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:my_library/data/models/card/my_card.dart';
import 'package:my_library/data/repository/firebase_firestore/fetch_mycard_from_firebase.dart';

class FetchMyCards {
  static Future<Map<String, MyCard>> fetchMyCards(String catPath) async {
    try {
      var querySnapshot =
          await FetchMyCardsFromFirebase.fetchMyCardsFromFirebaseApi(catPath);
      Map<String, MyCard> myCards = {};
      for (var doc in querySnapshot!.docs) {
        MyCard newCard = MyCard.docToMyCard(catPath, doc);
        newCard = await _fetchFilesFromFirebase(newCard);
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

  static Future<MyCard> _fetchFilesFromFirebase(MyCard myCard) async {
    ListResult imageResult = await FirebaseStorage.instance
        .ref(myCard.path)
        .child('images')
        .listAll();
    ListResult othersResult = await FirebaseStorage.instance
        .ref(myCard.path)
        .child('otherfiles')
        .listAll();
    for (var item in imageResult.items) {
      log(item.fullPath);
      await FirebaseStorage.instance
          .ref(item.fullPath)
          .writeToFile(myCard.imageFiles![item.fullPath]!);
    }

    return myCard;
  }
}
