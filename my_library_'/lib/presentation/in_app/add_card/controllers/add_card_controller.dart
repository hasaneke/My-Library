import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_library/core/utils/consts/allowed_extensions.dart';
import 'package:my_library/data/models/card/my_card.dart';
import 'package:my_library/presentation/domain/usecases/add_mycard.dart';
import 'package:uuid/uuid.dart';

class AddCardController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  /* VARIABLES TO ADD CARD*/
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
  final ImagePicker _picker = ImagePicker();

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
      pickedImage = await _picker.pickImage(source: ImageSource.camera);
      pickedImages.add(pickedImage!);
    }
  }

  pickedImageWithGallery() async {
    if (!isImageClicked.value) {
      pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      pickedImages.add(pickedImage!);
    }
  }

  pickFile() async {
    FilePickerResult? results = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: AllowedExtensions.allowedExtensions,
    );
    if (results != null) {
      pickedFiles.addAll(results.files.map((e) => File(e.path!)));
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
        isMarked: RxBool(false));
    newCard.imageFiles = _convertXFilesToFilesMap(pathForNewCard);
    newCard.otherFiles = _convertPickedFilesToMapFiles(pathForNewCard);
    AddCard.addMyCard(newCard);
    Get.back();
  }

  Map<String, File> _convertXFilesToFilesMap(String pathToCard) {
    Map<String, File> mapForImages = <String, File>{};
    for (var pickedFile in pickedImages) {
      String uniquePath = pathToCard + "/images/ " + const Uuid().v1();
      mapForImages[uniquePath] = File(pickedFile.path);
    }
    return mapForImages;
  }

  Map<String, File> _convertPickedFilesToMapFiles(String pathToCard) {
    Map<String, File> mapForFiles = <String, File>{};
    for (var pickedFile in pickedFiles) {
      String uniquePath = pathToCard + "/otherfiles/ " + const Uuid().v1();
      mapForFiles[uniquePath] = pickedFile;
    }
    return mapForFiles;
  }
}
