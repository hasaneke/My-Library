import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddCardScreenController extends GetxController {
  RxList<XFile> images = RxList();
  XFile? selectedXFileImage;
  Image? selectedImage;

  RxBool isImageClicked = false.obs;

  displayXFileImage(XFile image) {
    isImageClicked.value = true;
    selectedXFileImage = image;
  }

  displayImage(Image image) {
    log('?');
    isImageClicked.value = true;
    selectedImage = image;
  }

  undisplayImage() {
    isImageClicked.value = false;
  }
}
