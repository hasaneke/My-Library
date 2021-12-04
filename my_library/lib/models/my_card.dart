import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:my_library/database.dart';

class MyCard extends GetxController {
  String path; //Path to item<

  RxString? title = RxString('');
  RxString? shortExp = RxString('');
  RxString? longExp = RxString('');
  RxBool? isFavorite = false.obs;
  DateTime? dateTime;
  RxList<Image> images = RxList([]);
  bool isFetched = false;

  MyCard(
      {required this.path,
      this.title,
      this.shortExp,
      this.longExp,
      this.isFavorite,
      this.dateTime});

  Future<void> fetchImages() async {
    final result = await firebase_storage.FirebaseStorage.instance
        .ref(path)
        .child('images')
        .listAll();

    if (result.items.isNotEmpty) {
      resultHandler(result).then((value) {
        isFetched = true;
      });
    }
  }

  Future<void> resultHandler(ListResult result) async {
    result.items.getRange(1, result.items.length).forEach((element) async {
      log('fetched');
      String downloadUrl = await element.getDownloadURL();
      images.add(Image.network(downloadUrl));
    });
  }

  void toggleFavorite() {
    isFavorite!.value = isFavorite!.value;
  }

  Future<void> deleteTheCard() async {
    DatabaseController databaseController = Get.find();
    databaseController.deleteOneCard(path);
  }

  Future<void> onPopUpSelected(int item) async {
    switch (item) {
      case 0:
        log('?');
        break;
      case 1:
        deleteTheCard();
        break;
    }
  }
}
