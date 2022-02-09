import 'dart:io';

import 'package:get/get.dart';

import 'package:my_library/data/models/card/my_card.dart';
import 'package:my_library/data/models/category/my_category.dart';
import 'package:my_library/data/repository/firebase_firestore/add_card_to_firebas_api.dart';
import 'package:my_library/domain/usecases/mycard/upload_file/upload_images.dart';
import 'package:my_library/domain/usecases/mycard/upload_file/upload_other_files.dart';

class AddCard {
  static Future<void> addMyCard(MyCard myCard,
      {List<File>? imageFiles, List<File>? otherFiles}) async {
    /* ----------------- */
    myCard.fireImageFileList.value =
        await UploadImagesFiles.uploadImages(myCard.path, imageFiles!);

    myCard.fireOtherFileList.value =
        await UploadOtherFile.uploadOtherFiles(myCard.path, otherFiles!);
    AddMyCardToFirestoreApi.addMyCardToFirebase(myCard);
    MyCategory containerCategory = Get.find(tag: myCard.containerCatPath);
    containerCategory.myCards[myCard.path] = myCard;
  }
}
