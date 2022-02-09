import 'dart:developer';

import 'package:get/get.dart';
import 'package:my_library/data/models/card/my_card.dart';

import 'package:my_library/data/models/category/my_category.dart';

import 'package:my_library/core/utils/consts/pathtosave.dart';
import 'package:my_library/data/repository/firebase_auth/signed_user.dart';
import 'package:my_library/domain/usecases/mycategory/fetch_categories.dart';
import 'package:my_library/presentation/in_app/tabbar/controller/tabbar_controller.dart';

class DatastoreController extends GetxController {
  final RxMap<String, MyCategory> _maincategories =
      RxMap<String, MyCategory>({});
  final RxMap<String, MyCard> _allCards = RxMap<String, MyCard>({});
  RxMap<String, MyCategory> get maincategories => _maincategories;
  RxMap<String, MyCard> get allCards => _allCards;
  addMainCategory(MyCategory myCategory) {
    _maincategories[myCategory.path] = myCategory;
  }

  deleteMainCategory(MyCategory myCategory) {
    _maincategories.remove(myCategory.path);
  }

  @override
  void dispose() {
    Get.delete<DatastoreController>();
    super.dispose();
  }

  @override
  void onInit() async {
    _maincategories.value =
        await FetchCategories.fetchMainCategories(PathToSave().getMainPath);
    log(SignedUser.myUser!.uid);
    log(PathToSave().getMainPath);
    TabbarController tabbarController = Get.find();
    tabbarController.isLoading.value = false;
    for (var mainCat in maincategories.values) {
      _getAllCards(mainCat);
    }
    super.onInit();
  }

  void _getAllCards(MyCategory myCategory) {
    for (var subCat in myCategory.subCategories.values) {
      _getAllCards(subCat);
    }
    _allCards.addAll(myCategory.myCards);
  }
}
