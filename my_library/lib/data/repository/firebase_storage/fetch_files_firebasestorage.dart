import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:my_library/data/models/card/files/fire_image_file.dart';
import 'package:my_library/data/models/card/files/fire_other_file.dart';

class FetchFilesFirebaseStorage {
  static Future<List<FireImageFile>> fetchImages(String cardPath) async {
    List<FireImageFile> imagesList = List.empty(growable: true);

    final result =
        await FirebaseStorage.instance.ref(cardPath + '/images/').listAll();

    for (var result in result.items) {
      String downloadUrl = await result.getDownloadURL();
      imagesList.add(FireImageFile(
          downloadUrl: downloadUrl,
          image: Image.network(await result.getDownloadURL())));
    }
    return imagesList;
  }

  static Future<List<FireOtherFile>> fetchOtherFiles(String cardPath) async {
    List<FireOtherFile> otherFilesList = List.empty(growable: true);

    final result =
        await FirebaseStorage.instance.ref(cardPath + '/otherfiles/').listAll();
    for (var result in result.items) {
      String downloadUrl = await result.getDownloadURL();
      otherFilesList
          .add(FireOtherFile(name: result.name, downloadUrl: downloadUrl));
    }
    return otherFilesList;
  }
}
