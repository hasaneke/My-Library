import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:my_library/data/models/category/my_category.dart';
import 'package:my_library/presentation/in_app/add_card/controllers/add_card_controller.dart';

// ignore: must_be_immutable
class AddCardScreen extends GetView<AddCardController> {
  AddCardScreen({Key? key}) : super(key: key);
  MyCategory myCategory = Get.arguments;
  final size = Get.size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(children: [
          GestureDetector(
            onTap: controller.undisplayTappedImage,
            child: Opacity(
              opacity: controller.isImageClicked.value ? 0.4 : 1,
              child: SingleChildScrollView(
                physics: controller.isImageClicked.value
                    ? const NeverScrollableScrollPhysics()
                    : null,
                child: Column(
                  children: [
                    AppBar(
                      backgroundColor: context.theme.scaffoldBackgroundColor,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      title: Text('add_card'.tr),
                      centerTitle: true,
                    ),
                    Form(
                      key: controller.formKey,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  side: const BorderSide(color: Colors.black54),
                                ),
                                color: context.theme.scaffoldBackgroundColor,
                                elevation: 4,
                                child: TextFormField(
                                  enabled: !controller.isImageClicked.value,
                                  onSaved: (title) {
                                    controller.title = title!;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'title'.tr),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                        onPressed:
                                            controller.pickImageWithCamera,
                                        icon: const FaIcon(
                                          FontAwesomeIcons.camera,
                                          size: 30,
                                        )),
                                    IconButton(
                                      onPressed:
                                          controller.pickedImageWithGallery,
                                      icon: const Icon(
                                        Icons.photo_album,
                                        size: 35,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: controller.pickFile,
                                      icon: const FaIcon(
                                        FontAwesomeIcons.fileUpload,
                                        size: 30,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              controller.pickedImages.isEmpty
                                  ? Container()
                                  : SizedBox(
                                      height: 250,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: controller.pickedImages
                                            .map((image) => Row(
                                                  children: [
                                                    Stack(children: [
                                                      InkWell(
                                                        onTap: () => controller
                                                            .displayTappedImage(
                                                                image),
                                                        child: SizedBox(
                                                          height: 250,
                                                          child: Image.file(
                                                              File.fromUri(Uri(
                                                                  path: image
                                                                      .path))),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 0,
                                                        right: 0,
                                                        child: IconButton(
                                                            onPressed: () =>
                                                                controller
                                                                    .removeImage(
                                                                        image),
                                                            icon: const Icon(
                                                              Icons.close,
                                                              color: Colors.red,
                                                            )),
                                                      )
                                                    ]),
                                                    const SizedBox(
                                                      width: 9,
                                                    )
                                                  ],
                                                ))
                                            .toList(),
                                      ),
                                    ),
                              const SizedBox(
                                height: 6,
                              ),
                              controller.pickedFiles.isNotEmpty
                                  ? Column(
                                      children: controller.pickedFiles
                                          .map(
                                            (file) => ListTile(
                                              leading: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                backgroundImage: Image.asset(
                                                  'assets/pdf-icon.png',
                                                  fit: BoxFit.cover,
                                                ).image,
                                              ),
                                              title: Text(
                                                  file.path.split('/').last),
                                              onTap: () {
                                                log(file.path.split('/').last);
                                              },
                                            ),
                                          )
                                          .toList(),
                                    )
                                  : Container(),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  side: const BorderSide(color: Colors.black54),
                                ),
                                color: context.theme.scaffoldBackgroundColor,
                                elevation: 4,
                                child: TextFormField(
                                  enabled: !controller.isImageClicked.value,
                                  onSaved: (shortExp) {
                                    controller.shortExp = shortExp!;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'short_exp'.tr),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                height: 360,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    side:
                                        const BorderSide(color: Colors.black54),
                                  ),
                                  color: context.theme.scaffoldBackgroundColor,
                                  elevation: 4,
                                  child: TextFormField(
                                    enabled: !controller.isImageClicked.value,
                                    onSaved: (longExp) {
                                      controller.longExp = longExp!;
                                    },
                                    maxLines: null,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'long_exp'.tr),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                  onPressed: () =>
                                      controller.addCard(myCategory.path),
                                  child: Text(
                                    'add'.tr,
                                    style: TextStyle(
                                        color:
                                            context.textTheme.bodyText1!.color,
                                        fontSize: 17),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          controller.isImageClicked.value
              ? Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  top: 0,
                  child: Center(
                    child: InteractiveViewer(
                      child: SizedBox(
                        height: size.height * 0.6,
                        width: size.width * 0.7,
                        child: Container(
                          child: controller.tappedImage,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ]),
      ),
    );
  }
}
