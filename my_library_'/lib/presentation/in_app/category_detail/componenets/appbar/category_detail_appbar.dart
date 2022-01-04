import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/core/utils/popupmenu/pop_up_menu_constants.dart';
import 'package:my_library/data/models/category/my_category.dart';
import 'package:my_library/presentation/in_app/category_detail/componenets/appbar/controller/category_detail_appbar_controller.dart';

// ignore: must_be_immutable
class CategoryDetailAppbar extends StatelessWidget {
  MyCategory myCategory;
  CategoryDetailAppbar(this.myCategory, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryDetailAppbarController controller = Get.put(
        CategoryDetailAppbarController(myCategory),
        tag: myCategory.path);
    return AppBar(
      title: Obx(() => Center(
          child: controller.editTitle.value
              ? TextField(
                  controller: controller.textEditingController,
                  onSubmitted: (text) {
                    controller.changeTitle(newTitle: text);
                  })
              : Text(myCategory.title.value))),
      foregroundColor: Colors.black,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () => controller.openDiaolog(),
          icon: Icon(
            Icons.add_to_photos_outlined,
            color: context.theme.iconTheme.color,
            size: 30,
          ),
        ),
        PopupMenuButton<String>(
          onSelected: (choice) => controller.onPopUpSelected(choice),
          itemBuilder: (context) => PopUpMenuConstants.choices
              .map((choice) =>
                  PopupMenuItem<String>(value: choice, child: Text(choice.tr)))
              .toList(),
        )
      ],
    );
  }
}
