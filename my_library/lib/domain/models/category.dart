import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:my_library/domain/models/MyCard/abstractions/FirebaseMyCard.dart';
import 'package:my_library/domain/models/category/abstractions/FirebaseCategory.dart';

import 'package:my_library/domain/models/my_card.dart';
import 'package:my_library/data/repositories/database.dart';

import 'package:uuid/uuid.dart';

class Category extends GetxController with FirebaseCategory {
  String uniqueId;
  RxString? title = RxString(' ');
  String path; // Path to category
  String? previous_path;
  Color? color;
  RxMap<String, Category> altCategoriesWithMap = RxMap<String, Category>({});
  RxMap<String, MyCard> cards = RxMap<String, MyCard>({});
  bool isFetched = false;

  Category({
    required this.uniqueId,
    this.title,
    this.color,
    required this.path,
    this.previous_path,
  });
  static void createCategoryFromdoc(DocumentSnapshot doc) {}
  Future<void> fetchData() async {
    await _fetchCategories();
    await _fetchCards();
  }

  Future<void> addAltCategory({String? title, Color? color}) async {
    String uniqueIdForAltCat = await super.addAltCategoryToFirebase(path,
        title: title, color: color); //ALSO RETURNS A PATH TO ALTCAT
    String pathToAltCat = "$path/categories/$uniqueIdForAltCat";
    if (pathToAltCat != "ERROR") {
      final newCategory = Category(
          uniqueId: uniqueIdForAltCat,
          title: RxString(title!),
          color: color,
          previous_path: path,
          path: pathToAltCat);

      altCategoriesWithMap[pathToAltCat] = newCategory;

      Get.back();
    }
  }

  Future<void> addCard(Map<String, dynamic> values) async {
    try {
      // String uniqueIdForCard = Uuid().v1();
      DocumentSnapshot doc =
          await MyCardFirebase.uploadCardtoFirebaseFirestore(values);
      // final String pathToCard =
      //     '$path/cards/$uniqueIdForCard';
      var newCard = MyCard.createObjectFromDoc(doc);
      RxList<Image> fromXFilestoImages = (values['images'] as RxList<XFile>)
          .map((element) {
            return Image.file(File(element.path));
          })
          .toList()
          .obs;

      newCard.images = fromXFilestoImages;
      cards[newCard.path] = newCard;

      MyCardFirebase.uploadImagestoFirebasestorage(
          '${newCard.path}/images', values['images']);

      Get.back();
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<void> delete() async {
    if (cards.isNotEmpty) {
      clearCards();
    }
    if (altCategoriesWithMap.isNotEmpty) {
      altCategoriesWithMap.values.forEach((altCategory) {
        altCategory.delete();
      });
    }
    if (previous_path != null) {
      Category previousCategory = Get.find(tag: previous_path);

      previousCategory.altCategoriesWithMap.remove(path);
    } else {
      DatabaseController databaseController = Get.find();
      databaseController.categoriesWithMap.remove(path);
    }
    super.deleteCategoryFromFirebase(path);
  }

  Future<void> clearCards() async {
    super.deleteCardsFromFirebase(path);
    cards.clear();
  }

  Future<void> changeTitle(String newTitle) async {
    super.updateTitleOnFirebase(path, newTitle);
    title!.value = newTitle;
  }

  Future<void> _fetchCategories() async {
    super.fetchCategoriesFromFirebase(path).then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        log(doc.reference.path);
        final altCat = Category(
          uniqueId: doc['uniqueId'],
          title: RxString(doc['title']),
          color: Color(doc['color']),
          path: doc.reference.path,
          previous_path: path,
        );

        altCategoriesWithMap[doc.reference.path] = altCat;
      });
    });
  }

  Future<void> _fetchCards() async {
    super.fetchCardsFromFirebase(path).then((querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        MyCard myCard = MyCard.createObjectFromDoc(doc);

        ListResult result =
            await super.fetchCardFilesFromFirebaseStorage(doc.reference.path);

        if (result.items.isNotEmpty) {
          String downloadUrl = await result.items[0].getDownloadURL();
          myCard.images.add(Image.network(downloadUrl));
        }
        cards[doc.reference.path] = myCard;
      });
    });
  }

  Future<void> deleteCard(String pathToCard) async {
    MyCardFirebase.deleteFromFirebaseFirestore(pathToCard);
    MyCardFirebase.deleteFilesFromFirebaseStorage(pathToCard);
    cards.remove(pathToCard);
  }
}
