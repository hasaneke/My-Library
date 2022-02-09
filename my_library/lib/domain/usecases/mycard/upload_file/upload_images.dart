import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_library/data/models/card/files/fire_image_file.dart';
import 'package:my_library/data/repository/firebase_storage/upload_file_firebasestorage.dart';
import 'package:uuid/uuid.dart';

class UploadImagesFiles {
  static Future<List<FireImageFile>> uploadImages(
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
}
