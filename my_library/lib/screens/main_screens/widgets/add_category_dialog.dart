import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:my_library/database.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:my_library/models/category.dart';
import 'package:my_library/res/custom_colors.dart';

class AddCategoryDialog extends GetView<DatabaseController> {
  final _formKey = GlobalKey<FormState>();
  String? title;
  Color? selectedColor = const Color(0xcc0f0c08);
  Category? category;
  AddCategoryDialog({this.category});
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
                Get.showSnackbar(GetBar(
                  duration: const Duration(seconds: 1),
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
          // Wrap(
          //   direction: Axis.horizontal,
          //   children: Palette.colorbuttons.map<MaterialButton>((e) {
          //     return colorButton(e);
          //   }).toList(),
          // ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
            ),
            height: 120,
            child: BlockPicker(
              availableColors: Palette.colorButtons.values.toList(),
              pickerColor: selectedColor!,
              onColorChanged: (color) {
                selectedColor = color;
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.only(top: 15),
            child: Obx(() {
              return ElevatedButton(
                  onPressed: firstTimeClikced.value == false
                      ? () {
                          firstTimeClikced.value = true;
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            if (category == null) {
                              controller.addCategory(
                                title: title,
                                color: selectedColor,
                              );
                            } else {
                              if (category == null) {
                                controller.addCategory(
                                    title: title, color: selectedColor);
                              } else {
                                category!.addAltCategory(
                                    title, selectedColor, category!);
                              }
                            }
                          }
                        }
                      : null,
                  child: Text(
                    'add_category'.tr,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ));
            }),
          )
        ],
      ),
    );
  }
}
