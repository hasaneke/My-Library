import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/core/utils/routers/app_pages.dart';
import 'package:my_library/data/models/card/my_card.dart';
import 'package:my_library/data/repository/firebase_storage/download_file_firebasestorage.dart';
import 'package:my_library/domain/usecases/mycard/delete_file.dart';
import 'package:my_library/domain/usecases/mycard/delete_mycard.dart';

class CardDetailController extends GetxController {
  MyCard assignedCard;
  CardDetailController({required this.assignedCard});
  /*  OTHER VARIABLES */
  Image? tappedImage;
  RxBool isImageClicked = false.obs;
  Size size = Get.size;

  /* **************** */
  displayTappedImage(Image image) {
    isImageClicked.value = !isImageClicked.value;
    tappedImage = image;
  }

  deleteFile(String url) {
    DeleteFile.deleteFile(url: url);
    MyCard myCard = Get.find(tag: assignedCard.path);
    myCard.fireOtherFileList
        .removeWhere((element) => element.downloadUrl == url);
  }

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
        Get.toNamed(Routes.UPDATE_CARD_SCREEN_ROUTE, arguments: assignedCard);
        break;
      case 'delete':
        DeleteMyCard.deleteMyCard(assignedCard);
        Get.back();
    }
  }
}
