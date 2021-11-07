import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class MyCard extends GetxController {
  String? path; //Path to item<
  //var imagesUrl = RxList<String>([]);

  RxString? title = RxString('');
  RxString? shortExp = RxString('');
  RxString? longExp = RxString('');
  RxBool? isFavorite = false.obs;
  DateTime? dateTime;
  RxList<Image> images = RxList([]);
  bool isFetched = false;

  MyCard(
      {this.path,
      //required this.imagesUrl,
      this.title,
      this.shortExp,
      this.longExp,
      this.isFavorite,
      this.dateTime});
  Future<void> v1(ListResult result) async {
    int i = 0;
    result.items.forEach((element) async {
      if (i != 0) {
        String downloadUrl = await element.getDownloadURL();
        images.add(Image.network(downloadUrl));
      }
      i++;
    });
  }

  Future<void> fetchImages() async {
    final result = await firebase_storage.FirebaseStorage.instance
        .ref(path)
        .child('images')
        .listAll();

    if (result.items.isNotEmpty) {
      v1(result).then((value) {
        isFetched = true;
      });
    }
  }

  void toggleFavorite() {
    isFavorite!.value = isFavorite!.value;
  }
}
