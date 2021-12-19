import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:my_library/domain/models/category.dart';
import 'package:my_library/presentation/home/add_card/controller/add_card_screen_controller.dart';
import 'package:my_library/data/repositories/database.dart';
import 'package:image_picker/image_picker.dart';

class AddCardScreen extends GetView<AddCardScreenController> {
  AddCardScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final DatabaseController databaseController = Get.find();
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  final String? path = Get.arguments;
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Map<String, dynamic> values = {
      'path': path,
      'title': RxString(''),
      'short_exp': RxString(''),
      'long_exp': RxString(''),
      'images': RxList<XFile>([]),
    };

    return Obx(() => Scaffold(
          body: Stack(children: [
            GestureDetector(
              onTap: controller.undisplayImage,
              child: Opacity(
                opacity: controller.isImageClicked.value ? 0.4 : 1,
                child: SingleChildScrollView(
                  physics: controller.isImageClicked.value
                      ? NeverScrollableScrollPhysics()
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
                        key: _formKey,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    side:
                                        const BorderSide(color: Colors.black54),
                                  ),
                                  color: context.theme.scaffoldBackgroundColor,
                                  elevation: 4,
                                  child: TextFormField(
                                    enabled: !controller.isImageClicked.value,
                                    onSaved: (value) {
                                      values['title'] = RxString(value!);
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
                                          onPressed: !controller
                                                  .isImageClicked.value
                                              ? () async {
                                                  image = await _picker
                                                      .pickImage(
                                                          source: ImageSource
                                                              .camera)
                                                      .then((value) {
                                                    controller.images
                                                        .add(value!);
                                                  });
                                                }
                                              : null,
                                          icon: const FaIcon(
                                            FontAwesomeIcons.camera,
                                            size: 30,
                                          )),
                                      IconButton(
                                        onPressed: !controller
                                                .isImageClicked.value
                                            ? () async {
                                                image = await _picker
                                                    .pickImage(
                                                        source:
                                                            ImageSource.gallery,
                                                        imageQuality: 50)
                                                    .then((value) {
                                                  controller.images.add(value!);
                                                });
                                              }
                                            : null,
                                        icon: const Icon(
                                          Icons.photo_album,
                                          size: 35,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                controller.images.isEmpty
                                    ? Container()
                                    : Container(
                                        height: 250,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: controller.images
                                              .map((element) => Row(
                                                    children: [
                                                      Stack(children: [
                                                        InkWell(
                                                          onTap: controller
                                                                  .isImageClicked
                                                                  .value
                                                              ? null
                                                              : () => controller
                                                                  .displayXFileImage(
                                                                      element),
                                                          child: SizedBox(
                                                            height: 250,
                                                            child: Image.file(
                                                                File.fromUri(Uri(
                                                                    path: element
                                                                        .path))),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          top: 0,
                                                          right: 0,
                                                          child: IconButton(
                                                              onPressed: () =>
                                                                  controller
                                                                      .images
                                                                      .remove(
                                                                          element),
                                                              icon: const Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.red,
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
                                  height: 15,
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    side:
                                        const BorderSide(color: Colors.black54),
                                  ),
                                  color: context.theme.scaffoldBackgroundColor,
                                  elevation: 4,
                                  child: TextFormField(
                                    enabled: !controller.isImageClicked.value,
                                    onSaved: (value) {
                                      values['short_exp'] = RxString(value!);
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'short_exp'.tr),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: 360,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      side: BorderSide(color: Colors.black54),
                                    ),
                                    color:
                                        context.theme.scaffoldBackgroundColor,
                                    elevation: 4,
                                    child: TextFormField(
                                      enabled: !controller.isImageClicked.value,
                                      onSaved: (value) {
                                        values['long_exp'] = RxString(value!);
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
                                Obx(
                                  () => databaseController.isItemUploading.value
                                      ? const CircularProgressIndicator(
                                          color: Colors.black,
                                        )
                                      : ElevatedButton(
                                          onPressed: isClicked
                                              ? null
                                              : () {
                                                  _formKey.currentState!.save();

                                                  values['images'] =
                                                      controller.images;
                                                  Category category =
                                                      Get.find(tag: path);
                                                  category.addCard(values);
                                                },
                                          child: Text(
                                            'add'.tr,
                                            style: TextStyle(
                                                color: context
                                                    .textTheme.bodyText1!.color,
                                                fontSize: 17),
                                          )),
                                )
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
                          child: Image.file(
                            File.fromUri(
                                Uri(path: controller.selectedXFileImage!.path)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ]),
        ));
  }
}
