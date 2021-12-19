import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CardDetailScreenController extends GetxController {
  RxBool isImageClicked = false.obs;
  Image? selectedImage;
  displayImage(Image image) {
    isImageClicked.value = true;
    selectedImage = image;
  }

  undisplayImage() {
    isImageClicked.value = false;
  }
}
