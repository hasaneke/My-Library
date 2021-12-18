import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:my_library/data/repositories/database.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';

class MyCardFirebase {
  DatabaseController databaseController = Get.find();

/* -----FIREBASE FİRESTORE----- */
  static Future<DocumentSnapshot> uploadCardtoFirebaseFirestore(
    Map<String, dynamic> values,
  ) async {
    String uniqueId = Uuid().v1();
    var reference = FirebaseFirestore.instance
        .collection('${values['path']}/cards')
        .doc(uniqueId);
    reference.set({
      'unique_id': uniqueId,
      'container_cat_path': values['path'],
      'title': values['title']!.value,
      'short_exp': values['short_exp']!.value,
      'long_exp': values['long_exp']!.value,
      'date': DateTime.now().toString(),
      'is_marked': false,
    });
    return reference.get();
  }

  static Future<void> deleteFromFirebaseFirestore(String pathToCard) async {
    await FirebaseFirestore.instance.doc(pathToCard).delete();
  }

  Future<void> markItToFirebaseFirestore(
      {required String uniqueId, required String path}) async {
    FirebaseFirestore.instance.doc(path).update({'is_marked': true});

    FirebaseFirestore.instance
        .collection('users/${databaseController.userId}/markedCards')
        .doc(uniqueId)
        .set({'path': path});
  }

  Future<void> unmarkItFromFirebaseFirestore(
      {required String uniqueId, required String path}) async {
    FirebaseFirestore.instance.doc(path).update({'is_marked': false});
    FirebaseFirestore.instance
        .doc('users/${databaseController.userId}/markedCards/$uniqueId')
        .delete();
  }

  /* -----FIREBASE STORAGE------ */
  Future<ListResult> fetchImagesFromFirebaseStorage(String path) async {
    return await FirebaseStorage.instance.ref(path).child('images').listAll();
  }

  static Future<void> deleteFilesFromFirebaseStorage(String pathToCard) async {
    final result =
        await FirebaseStorage.instance.ref("$pathToCard/images").listAll();
    if (result.items.isNotEmpty) {
      result.items.forEach((element) {
        element.delete();
      });
    }
  }

  static Future<void> uploadImagestoFirebasestorage(
      String path, RxList<XFile> images) async {
    for (var image in images) {
      var uIdForImage = Uuid().v1();
      final ref = FirebaseStorage.instance.ref("$path/$uIdForImage");

      await ref.putFile(File(image.path));
    }
  }
}
