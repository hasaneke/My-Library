import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:my_library/controllers/add_screen_controller.dart';

import 'package:my_library/database.dart';
import 'package:image_picker/image_picker.dart';

class AddItemScreen extends GetView<AddCardScreenController> {
  AddItemScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final DatabaseController databaseController = Get.find();
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  @override
  Widget build(BuildContext context) {
    Map<String, RxString> values = {
      'title': RxString(''),
      'short_exp': RxString(''),
      'long_exp': RxString(''),
    };
    final String? path = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text('add_card'.tr),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
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
                      side: const BorderSide(color: Colors.black54),
                    ),
                    color: context.theme.scaffoldBackgroundColor,
                    elevation: 4,
                    child: TextFormField(
                      onSaved: (value) {
                        values['title'] = RxString(value!);
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: 'title'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () async {
                              image = await _picker
                                  .pickImage(source: ImageSource.camera)
                                  .then((value) {
                                controller.images.add(value!);
                              });
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.camera,
                              size: 30,
                            )),
                        IconButton(
                          onPressed: () async {
                            image = await _picker
                                .pickImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 50)
                                .then((value) {
                              controller.images.add(value!);
                            });
                          },
                          icon: const Icon(
                            Icons.photo_album,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() {
                    if (controller.images.isEmpty) {
                      return Container();
                    } else {
                      return Container(
                        height: 250,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: controller.images
                              .map((element) => Container(
                                    height: 250,
                                    child: Image.file(
                                        File.fromUri(Uri(path: element.path))),
                                  ))
                              .toList(),
                        ),
                      );
                    }
                  }),
                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                      side: const BorderSide(color: Colors.black54),
                    ),
                    color: context.theme.scaffoldBackgroundColor,
                    elevation: 4,
                    child: TextFormField(
                      onSaved: (value) {
                        values['short_exp'] = RxString(value!);
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Short Explanation'),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 360,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                        side: BorderSide(color: Colors.black54),
                      ),
                      color: context.theme.scaffoldBackgroundColor,
                      elevation: 4,
                      child: TextFormField(
                        onSaved: (value) {
                          values['long_exp'] = RxString(value!);
                        },
                        maxLines: null,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '  Long Explanation'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Obx(
                    () => databaseController.isItemLoading.value
                        ? const CircularProgressIndicator(
                            color: Colors.black,
                          )
                        : ElevatedButton(
                            onPressed: () {
                              _formKey.currentState!.save();
                              final DatabaseController databaseController =
                                  Get.find();
                              databaseController.addCard(
                                  values, path!, controller.images);
                            },
                            child: Text(
                              'add'.tr,
                              style: TextStyle(
                                  color: context.textTheme.bodyText1!.color,
                                  fontSize: 17),
                            )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
