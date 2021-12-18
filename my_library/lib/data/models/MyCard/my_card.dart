import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:my_library/data/models/MyCard/abstractions/FirebaseMyCard.dart';
import 'package:my_library/data/models/category/abstractions/FirebaseCategory.dart';
import 'package:my_library/data/models/category/category.dart';
import 'package:my_library/data/repositories/database.dart';
import 'package:my_library/screens/navigation_screens/tab_bar_screens/marked/controller/marked_screen_controller.dart';

class MyCard extends GetxController with MyCardFirebase {
  String path; //Path to item<
  String uniqueId;
  String containerCatPath;
  RxString? title = RxString('');
  RxString? shortExp = RxString('');
  RxString? longExp = RxString('');
  RxBool? isMarked = RxBool(false);
  DateTime? dateTime;
  RxList<Image> images = RxList([]);
  bool isFetched = false;

  MyCard(
      {required this.containerCatPath,
      required this.path,
      required this.uniqueId,
      this.title,
      this.shortExp,
      this.longExp,
      this.isMarked,
      this.dateTime});

  static MyCard createObjectFromDoc(DocumentSnapshot doc) {
    return MyCard(
        uniqueId: doc.get('unique_id'),
        containerCatPath: doc.get('container_cat_path'),
        path: doc.reference.path,
        title: RxString(doc.get('title')),
        shortExp: RxString(doc.get('short_exp')),
        longExp: RxString(doc.get('long_exp')),
        dateTime: DateTime.parse(doc.get('date')),
        isMarked: RxBool(doc.get('is_marked')));
  }

  Future<void> fetchImages() async {
    ListResult result = await super.fetchImagesFromFirebaseStorage(path);

    if (result.items.isNotEmpty) {
      resultHandler(result).then((value) {
        isFetched = true;
      });
    }
  }

  Future<void> resultHandler(ListResult result) async {
    result.items.getRange(1, result.items.length).forEach((element) async {
      //first image is already in the ram, no need to download twice.
      log('fetched');
      String downloadUrl = await element.getDownloadURL();
      images.add(Image.network(downloadUrl));
    });
  }

  Future<void> toggleMark() async {
    MarkedScreenController markedScreenController = Get.find();
    if (isMarked!.value == false) {
      super.markItToFirebaseFirestore(uniqueId: uniqueId, path: path);

      markedScreenController.addCardToMarkedList(this);
    } else {
      super.unmarkItFromFirebaseFirestore(uniqueId: uniqueId, path: path);
      markedScreenController.removeCardFromMarkedList(this);
    }
    isMarked!.value = !isMarked!.value;
  }

  Future<void> onPopUpSelected(String item) async {
    switch (item) {
      case 'edit':
        log('?');
        break;
      case 'delete':
        Category category = Get.find(tag: containerCatPath);
        category.deleteCard(path);
        Get.back();
        break;
    }
  }
}
