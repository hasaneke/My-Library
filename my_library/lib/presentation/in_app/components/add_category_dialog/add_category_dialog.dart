import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:my_library/core/utils/colors/custom_colors.dart';
import 'package:my_library/presentation/in_app/components/add_category_dialog/controller/add_category_dialog_controller.dart';

// ignore: must_be_immutable
class AddCategoryDialog extends GetView<AddCategoryDialogController> {
  String pathToSave;
  // ignore: use_key_in_widget_constructors
  AddCategoryDialog({required this.pathToSave});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.name,
            decoration: InputDecoration(hintText: 'category_title'.tr),
            onSaved: (value) {
              controller.title = value!;
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
              pickerColor: controller.selectedColor,
              onColorChanged: (color) {
                controller.selectedColor = color;
              },
            ),
          ),
          Container(
              padding: const EdgeInsets.only(top: 15),
              child: ElevatedButton(
                  onPressed: () => pathToSave.isNotEmpty
                      ? controller.addSubCategory(containerPath: pathToSave)
                      : controller.addMainCategory(),
                  child: Text(
                    'add'.tr,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ))),
        ],
      ),
    );
  }
}
