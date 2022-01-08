import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_library/data/models/card/my_card.dart';
import 'package:my_library/presentation/domain/usecases/delete_mycard.dart';

class CardDetailController extends GetxController {
  late MyCard assignedCard;
  Image? tappedImage;
  RxBool isImageClicked = false.obs;
  displayTappedImage(File image) {
    isImageClicked.value = !isImageClicked.value;
    tappedImage = Image.file(image);
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
