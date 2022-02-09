import 'dart:io';
import 'package:my_library/data/models/card/files/fire_other_file.dart';
import 'package:my_library/data/repository/firebase_storage/upload_file_firebasestorage.dart';

class UploadOtherFile {
  static Future<List<FireOtherFile>> uploadOtherFiles(
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
