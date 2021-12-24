import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:my_library/core/utils/colors/custom_colors.dart';
import 'package:my_library/data/models/category.dart';
import 'package:my_library/data/repositories/database.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AddCategoryDialog extends GetView<DatabaseController> {
  final _formKey = GlobalKey<FormState>();
  String? title;
  Color selectedColor = const Color(0xcc0f0c08);
  String path;
  AddCategoryDialog(this.path, {Key? key}) : super(key: key);

  var firstTimeClikced = false.obs;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.name,
            decoration: InputDecoration(hintText: 'category_title'.tr),
            onSaved: (value) {
              title = value!;
            },
            validator: (value) {
              if (value!.isEmpty) {
                Get.showSnackbar(const GetSnackBar(
                  duration: Duration(seconds: 1),
                  message: 'Enter a title',
                ));
                return 'empty';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
            ),
            height: 120,
            child: BlockPicker(
              availableColors: Palette.colorButtons.values.toList(),
              pickerColor: selectedColor,
              onColorChanged: (color) {
                selectedColor = color;
              },
            ),
          ),
          Obx(
            () => Container(
                padding: const EdgeInsets.only(top: 15),
                child: ElevatedButton(
                    onPressed: !firstTimeClikced.value
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              firstTimeClikced.value = true;
                              _formKey.currentState!.save();
                              if (path.isEmpty) {
                                controller.addCategory(
                                    title: title, color: selectedColor);
                              } else {
                                Category category = Get.find(tag: path);
                                category.addAltCategory(
                                    title: title, color: selectedColor);
                              }
                            } else {
                              Get.showSnackbar(const GetSnackBar(
                                message: "Something happend!",
                                duration: Duration(seconds: 2),
                              ));
                            }
                          }
                        : null,
                    child: Text(
                      'add'.tr,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ))),
          )
        ],
      ),
    );
  }
}
