import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:my_library/data/models/MyCard/abstractions/my_card_firebase.dart';
import 'package:my_library/data/models/category/abstractions/FirebaseCategory.dart';

import 'package:my_library/data/models/MyCard/my_card.dart';
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

  late bool isFetched;
  Category({
    required this.uniqueId,
    this.title,
    this.color,
    required this.path,
    this.previous_path,
  });

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
      String uniqueIdForCard = Uuid().v1();
      MyCardFirebase.uploadCardtoFirebaseFirestore(uniqueIdForCard, values)
          .then((value) {
        final String pathToCard =
            '${values['path']}/cards/$uniqueId'; //path in firebase firestore
        final newCard = MyCard(
          uniqueId: uniqueIdForCard,
          containerCatPath: path,
          path: '${values['path']}/cards/$uniqueIdForCard',
          title: values['title'],
          shortExp: values['short_exp'],
          longExp: values['long_exp'],
          isMarked: RxBool(false),
          dateTime: DateTime.now(),
        );
        RxList<Image> fromXFilestoImages = (values['images'] as RxList<XFile>)
            .map((element) {
              return Image.file(File(element.path));
            })
            .toList()
            .obs;

        newCard.images = fromXFilestoImages;
        cards[pathToCard] = newCard;

        MyCardFirebase.uploadImagestoFirestorage(
            '${newCard.path}/images', values['images']);
      });
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
        MyCard card = MyCard(
          uniqueId: doc['uniqueId'],
          containerCatPath: path,
          path: doc.reference.path,
          title: RxString(doc['title']),
          shortExp: RxString(doc['short_exp']),
          longExp: RxString(doc['long_exp']),
          dateTime: DateTime.parse(doc['date']),
          isMarked: RxBool(doc['is_marked']),
        );
        log(doc.reference.path);
        ListResult result =
            await super.fetchCardFilesFromFirebaseStorage(doc.reference.path);

        if (result.items.isNotEmpty) {
          String downloadUrl = await result.items[0].getDownloadURL();
          card.images.add(Image.network(downloadUrl));
        }

        cards[doc.reference.path] = card;
      });
    });
  }

  Future<void> deleteCard(String pathToCard) async {
    await FirebaseFirestore.instance.doc(pathToCard).delete();

    final result =
        await FirebaseStorage.instance.ref("$pathToCard/images").listAll();
    cards.remove(pathToCard);
    if (result.items.isNotEmpty) {
      result.items.forEach((element) {
        element.delete();
      });
    }
  }

  @override
  void onInit() {
    isFetched = false;
    super.onInit();
  }
}
