import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_library/core/utils/consts/allowed_extensions.dart';

import 'package:my_library/data/models/card/my_card.dart';
import 'package:my_library/domain/usecases/mycard/add_mycard.dart';
import 'package:uuid/uuid.dart';

class AddCardController extends GetxController {
  String title = '';
  String shortExp = '';
  String longExp = '';
  RxList<XFile> pickedImages = RxList<XFile>([]);
  RxList<File> pickedFiles = RxList<File>([]);

  Map<String, dynamic> data = <String, dynamic>{};
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /* VARIABLES AND METHODS FOR INTERACTION WITH SCREEN*/
  Size size = Get.size;
  XFile? pickedImage;
  Image? tappedImage;
  RxBool isImageClicked = false.obs;
  RxBool isUploading = false.obs;
  final ImagePicker _picker = ImagePicker();
  /* ******************************************** */
  undisplayTappedImage() {
    isImageClicked.value = false;
  }

  displayTappedImage(XFile displayedImage) {
    isImageClicked.value = true;

    tappedImage = Image.file(File(displayedImage.path));
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
  removeImage(XFile removedImage) {
    pickedImages.remove(removedImage);
  }

  removeFile(File file) {
    pickedFiles.remove(file);
  }

  addCard({required String catPath}) {
    formKey.currentState!.save();
    isUploading.value = true;

    String path = catPath + '/cards/' + const Uuid().v1();
    MyCard newCard = MyCard(
        path: path,
        containerCatPath: catPath,
        title: RxString(title),
        shortExp: RxString(shortExp),
        longExp: RxString(longExp),
        date: DateTime.now(),
        isMarked: RxBool(false));

    AddCard.addMyCard(newCard,
            imageFiles: pickedImages.map((e) => File(e.path)).toList(),
            otherFiles: pickedFiles)
        .then((value) {
      isUploading.value = false;
      Future.delayed(const Duration(milliseconds: 50), () {
        Get.back();
      });
    });
  }
}
