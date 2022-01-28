import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class UploadFileFirebaseStorage {
  static Future<String> uploadFileFirebaseStorage(
      {required String pathToSave, required File file}) async {
    await FirebaseStorage.instance.ref(pathToSave).putFile(file);
    return await FirebaseStorage.instance.ref(pathToSave).getDownloadURL();
  }
}
