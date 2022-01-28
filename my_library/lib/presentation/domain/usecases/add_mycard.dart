import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_library/data/models/card/files/fire_image_file.dart';
import 'package:my_library/data/models/card/files/fire_other_file.dart';
import 'package:my_library/data/models/card/my_card.dart';
import 'package:my_library/data/models/category/my_category.dart';
import 'package:my_library/data/repository/firebase_firestore/add_card_to_firebase.dart';
import 'package:my_library/data/repository/firebase_storage/upload_file_firebasestorage.dart';
import 'package:uuid/uuid.dart';

class AddCard {
  static Future<void> addMyCard(MyCard myCard,
      {List<File>? imageFiles, List<File>? otherFiles}) async {
    /* ----------------- */
    myCard.fireImageFileList.value =
        await _uploadImageFilesToFirebaseStorage(myCard.path, imageFiles!);

    myCard.fireOtherFileList.value =
        await _uploadOtherFilesToFirebaseStorage(myCard.path, otherFiles!);
    AddMyCardToFirebase.addMyCardToFirebase(myCard);
    MyCategory containerCategory = Get.find(tag: myCard.containerCatPath);
    containerCategory.myCards[myCard.path] = myCard;
  }

  static Future<List<FireImageFile>> _uploadImageFilesToFirebaseStorage(
      String cardPath, List<File> filesToUpload) async {
    List<FireImageFile> imageFilesList = List.empty(growable: true);
    for (var file in filesToUpload) {
      String pathToSave = cardPath + "/images/" + const Uuid().v1();
      String downloadUrl =
          await UploadFileFirebaseStorage.uploadFileFirebaseStorage(
              pathToSave: pathToSave, file: file);
      imageFilesList.add(
          FireImageFile(downloadUrl: downloadUrl, image: Image.file(file)));
    }
    return imageFilesList;
  }

  static Future<List<FireOtherFile>> _uploadOtherFilesToFirebaseStorage(
      String cardPath, List<File> filesToUpload) async {
    List<FireOtherFile> otherFilesList = List.empty(growable: true);
    for (var file in filesToUpload) {
      String pathToSave = cardPath + "/otherfiles/" + file.path.split('/').last;
      String downloadUrl =
          await UploadFileFirebaseStorage.uploadFileFirebaseStorage(
              pathToSave: pathToSave, file: file);
      otherFilesList.add(FireOtherFile(
          name: file.path.split('/').last, downloadUrl: downloadUrl));
    }
    return otherFilesList;
  }
}
