import 'dart:developer';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import 'package:uuid/uuid.dart';

class FirebaseCategory {
  Future<String> addAltCategoryToFirebase(String path,
      {String? title, Color? color}) async {
    String uniqueId = Uuid().v1();
    await FirebaseFirestore.instance
        .collection('$path/categories')
        .doc(uniqueId)
        .set({
      'uniqueId': uniqueId,
      'title': title,
      'color': color!.value,
    }).onError((error, stackTrace) => "ERROR");
    return uniqueId;
  }

  Future<bool> deleteCategoryFromFirebase(String path) async {
    FirebaseFirestore.instance
        .doc(path)
        .delete()
        .whenComplete(() => true)
        .onError((error, stackTrace) => false);
    return false;
  }

  Future<bool> deleteCardsFromFirebase(String path) async {
    FirebaseFirestore.instance
        .collection('$path/cards')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        await doc.reference.delete();
        final result = await FirebaseStorage.instance
            .ref("${doc.reference.path}/images")
            .listAll();
        if (result.items.isNotEmpty) {
          result.items.forEach((element) {
            element.delete();
          });
        }
      });
    }).whenComplete(() => true);
    return false;
  }

  Future<bool> updateTitleOnFirebase(String path, String newTitle) async {
    await FirebaseFirestore.instance.doc(path).update({
      'title': newTitle,
    }).whenComplete(() => true);
    return false;
  }

  Future<QuerySnapshot> fetchCategoriesFromFirebase(String path) async {
    return await FirebaseFirestore.instance
        .collection('$path/categories')
        .get();
  }

  Future<QuerySnapshot> fetchCardsFromFirebase(String path) async {
    return await FirebaseFirestore.instance.collection('$path/cards').get();
  }

  Future<ListResult> fetchCardFilesFromFirebaseStorage(
      String pathToCard) async {
    return await firebase_storage.FirebaseStorage.instance
        .ref(pathToCard)
        .child('images')
        .listAll();
  }
}
