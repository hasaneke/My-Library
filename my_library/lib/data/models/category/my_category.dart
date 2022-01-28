import 'dart:developer';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:my_library/data/models/card/my_card.dart';
import 'package:my_library/data/repository/firebase_firestore/delete_mycard_from_firebase.dart';

import 'package:my_library/presentation/domain/data/datastore_controller.dart';

import 'package:my_library/presentation/domain/usecases/delete_category.dart';

import 'package:my_library/presentation/domain/usecases/update_category_title.dart';
import 'package:my_library/presentation/in_app/tabbar/pages/tabs/all_cards_screen/controller/all_cards_controller.dart';
import 'package:my_library/presentation/in_app/tabbar/pages/tabs/marked_cards/controllers/marked_cards_controller.dart';

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

    log('added');
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
    AllCardsController allCardsController = Get.find();
    MarkedCardsController markedCardsController = Get.find();
    for (var myCard in myCards.values) {
      allCardsController.removeFromAllCardslist(myCard);
      markedCardsController.removeMyCardFromMarkedCards(myCard);
      DeleteMyCardFromFirebaseApi.deleteMyCardFromFirebaseApi(myCard.path);
    }
  }

  Future<void> changeTitle(String newTitle) async {
    title.value = await UpdateCategoryTitle.updateTitle(newTitle, path);
  }

  @override
  void onInit() {
    myCards.listen((myCards) {
      AllCardsController allCardsController = Get.find();
      for (var myCard in myCards.values) {
        allCardsController.addInAllCards(myCard);
      }
    });
    super.onInit();
  }
}
