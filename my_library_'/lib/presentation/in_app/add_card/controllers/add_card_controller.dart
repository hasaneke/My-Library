import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_library/data/models/card/my_card.dart';
import 'package:my_library/presentation/core/usecases/add_mycard.dart';
import 'package:uuid/uuid.dart';

class AddCardController extends GetxController {
  /* VARIABLES TO ADD CARD*/
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String title = '';
  String shortExp = '';
  String longExp = '';
  RxList<XFile> pickedImages = RxList<XFile>([]);
  /* ------------------------*/

  /* VARIABLES AND METHODS FOR INTERACTION WITH SCREEN*/
  XFile? selectedXFile;
  XFile? pickedImage;

  RxBool isImageClicked = false.obs;
  RxBool isAddButtonClicked = false.obs;
  Size deviceSize = Get.size;
  ImagePicker picker = ImagePicker();
  undisplayImage() {
    isImageClicked.value = false;
  }

  displayImage(XFile displayedImage) {
    isImageClicked.value = true;

    selectedXFile = displayedImage;
  }

  removeImage(XFile removedImage) {
    pickedImages.remove(removedImage);
  }

  /* -------------------------------------- */
  /* PICKING IMAGES */
  pickImageWithCamera() async {
    if (!isImageClicked.value) {
      pickedImage = await picker.pickImage(source: ImageSource.camera);
      pickedImages.add(pickedImage!);
    }
  }

  pickedImageWithGallery() async {
    if (!isImageClicked.value) {
      pickedImage = await picker.pickImage(source: ImageSource.gallery);
      pickedImages.add(pickedImage!);
    }
  }
  /* ----------------- */

  addCard(String containerCategoryPath) {
    formKey.currentState!.save();

    String pathForNewCard =
        containerCategoryPath + '/cards/' + const Uuid().v1();
    MyCard newCard = MyCard(
        path: pathForNewCard,
        containerCatPath: containerCategoryPath,
        title: RxString(title),
        shortExp: RxString(shortExp),
        longExp: RxString(longExp),
        date: DateTime.now(),
        isMarked: RxBool(false),
        images: RxList(convertXFilesToImages()));
    AddCard.addMyCard(newCard);
    Get.back();
  }

  List<Image> convertXFilesToImages() {
    List<Image> images =
        pickedImages.map((xFile) => Image.file(File(xFile.path))).toList();

    return images;
  }
}
