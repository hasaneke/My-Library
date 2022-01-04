import 'dart:developer';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:my_library/data/models/card/my_card.dart';

import 'package:my_library/presentation/core/data/datastore_controller.dart';

import 'package:my_library/presentation/core/usecases/delete_category.dart';
import 'package:my_library/presentation/core/usecases/delete_mycard.dart';

import 'package:my_library/presentation/core/usecases/update_category_title.dart';

class MyCategory extends GetxController {
  String containerCategoryPath;
  String path;
  RxString title;
  Color color;
  RxMap<String, MyCategory> subCategories = RxMap<String, MyCategory>({});
  RxMap<String, MyCard> myCards = RxMap<String, MyCard>({});
  MyCategory({
    this.containerCategoryPath = '',
    required this.path,
    required this.title,
    required this.color,
  });

  Map<String, dynamic> get fromMyCategoryToDoc {
    return {
      'title': title.value,
      'color_code': color.value,
    };
  }

  Future<void> addSubCategory(MyCategory myCategory) async {
    subCategories[myCategory.path] = myCategory;
  }

  Future<void> destroy() async {
    DeleteCategory.recrusiveDeletion(this).then((value) {
      if (containerCategoryPath.isNotEmpty) {
        MyCategory containerCategory = Get.find(tag: containerCategoryPath);
        containerCategory.subCategories.remove(path);
      } else {
        DatastoreController datastoreController = Get.find();
        datastoreController.deleteMainCategory(this);
      }
    });
  }

  Future<void> clearCards() async {
    for (var myCard in myCards.values) {
      DeleteMyCard.deleteMyCard(myCard);
    }
  }

  Future<void> changeTitle(String newTitle) async {
    title.value = await UpdateCategoryTitle.updateTitle(newTitle, path);
  }

  @override
  void onReady() {
    log(title + 'called again');
    super.onReady();
  }

  @override
  void onInit() {
    log(title + 'is initialized');
    super.onInit();
  }
}
