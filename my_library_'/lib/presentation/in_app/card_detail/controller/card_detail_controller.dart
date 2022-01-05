import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_library/data/models/card/my_card.dart';
import 'package:my_library/presentation/core/usecases/delete_mycard.dart';

class CardDetailController extends GetxController {
  late MyCard assignedCard;
  Image? selectedImage;
  RxBool isImageClicked = false.obs;
  displayImage(Image image) {}
  undisplayImage() {}
  toggleMark() {
    assignedCard.toggleMark();
  }

  onPopUpSelected(String choice) {
    switch (choice) {
      case 'edit':
        log('edit');
        break;
      case 'delete':
        DeleteMyCard.deleteMyCard(assignedCard);
        Get.back();
    }
  }
}
