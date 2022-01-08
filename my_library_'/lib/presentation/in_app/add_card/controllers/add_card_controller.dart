import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_library/data/models/card/my_card.dart';
import 'package:my_library/presentation/domain/usecases/add_mycard.dart';
import 'package:uuid/uuid.dart';

class AddCardController extends GetxController {
  /* VARIABLES TO ADD CARD*/
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String title = '';
  String shortExp = '';
  String longExp = '';
  RxList<XFile> pickedImages = RxList<XFile>([]);
  RxList<File> pickedFiles = RxList<File>([]);
  /* ------------------------*/

  /* VARIABLES AND METHODS FOR INTERACTION WITH SCREEN*/
  XFile? pickedImage;
  Image? tappedImage;
  RxBool isImageClicked = false.obs;

  ImagePicker picker = ImagePicker();
  undisplayTappedImage() {
    isImageClicked.value = false;
  }

  displayTappedImage(XFile displayedImage) {
    isImageClicked.value = true;

    tappedImage = Image.file(File(displayedImage.path));
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
    );
    AddCard.addMyCard(newCard, _convertXFilesToFiles());
    Get.back();
  }

  List<File> _convertXFilesToFiles() {
    List<File> imageFiles =
        pickedImages.map((xFile) => File(xFile.path)).toList();

    return imageFiles;
  }
}
