import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/data/models/card/my_card.dart';
import 'package:my_library/data/repository/firebase_storage/download_file_firebasestorage.dart';
import 'package:my_library/presentation/domain/usecases/delete_file.dart';
import 'package:my_library/presentation/domain/usecases/delete_mycard.dart';

class CardDetailController extends GetxController {
  late MyCard assignedCard;
  Image? tappedImage;
  RxBool isImageClicked = false.obs;
  displayTappedImage(Image image) {
    isImageClicked.value = !isImageClicked.value;
    tappedImage = image;
  }

  // deleteFile(String url) {
  //   DeleteFile.deleteFile(url);
  //   MyCard myCard = Get.find(tag: assignedCard.path);
  //   myCard.fireImageFileList
  //       .removeWhere((element) => element.downloadUrl == url);
  // }

  downloadFile(String downloadUrl, String name) {
    DownloadFileFirebaseStorage.downloadFileExample(downloadUrl, name);
  }

  undisplayTappedImage() {
    isImageClicked.value = false;
  }

  toggleMark() {
    assignedCard.toggleMark();
  }

  onPopUpSelected(String choice) {
    switch (choice) {
      case 'edit':
        assignedCard.title!.value = "Has changed";
        break;
      case 'delete':
        DeleteMyCard.deleteMyCard(assignedCard);
        Get.back();
    }
  }
}
