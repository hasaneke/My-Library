import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/core/utils/routers/app_pages.dart';
import 'package:my_library/data/models/card/my_card.dart';

import 'package:my_library/data/models/category/my_category.dart';
import 'package:my_library/presentation/in_app/category_detail/componenets/appbar/category_detail_appbar.dart';
import 'package:my_library/presentation/in_app/category_detail/controllers/category_detail_controller.dart';
import 'package:my_library/presentation/in_app/components/my_card_item/my_card_item.dart';
import 'package:my_library/presentation/in_app/components/my_category_gridview/my_category_gridview.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class CategoryDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyCategory myCategory = Get.arguments;

    return Scaffold(
      body: SingleChildScrollView(
          child: Obx(
        () => Column(
          children: [
            CategoryDetailAppbar(myCategory),
            (myCategory.myCards.isEmpty && myCategory.subCategories.isEmpty)
                ? SizedBox(
                    height: Get.size.height,
                    child: const Center(
                      child: Text('Empty'),
                    ),
                  )
                : Column(
                    children: [
                      _bodyForCategories(myCategory),
                      cardListView(myCategory.myCards)
                    ],
                  )
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            context.theme.floatingActionButtonTheme.backgroundColor,
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () {
          Get.toNamed(Routes.ADD_CARD_SCREE_ROUTE, arguments: myCategory);
        },
      ),
    );
  }

  ListView cardListView(RxMap<String, MyCard> myCards) {
    return ListView.builder(
      controller: ScrollController(keepScrollOffset: true),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, index) {
        var card = myCards.values.elementAt(index);
        return MyCardItem(card);
      },
      itemCount: myCards.length,
    );
  }

  Widget _bodyForCategories(MyCategory myCategory) {
    CategoryDetailController controller =
        Get.put(CategoryDetailController(), tag: myCategory.path);

    return myCategory.subCategories.isNotEmpty
        ? controller.isCatOpened.value
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.only(top: 9),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black54, width: 2)),
                  child: Column(
                    children: [
                      MyCategoryGridView(myCategory.subCategories),
                      IconButton(
                          onPressed: () => controller.toggleCat(),
                          icon: const Icon(
                            Icons.arrow_upward,
                            color: Colors.black54,
                          ))
                    ],
                  ),
                ),
              )
            : IconButton(
                onPressed: () => controller.toggleCat(),
                icon: const Icon(Icons.grid_view))
        : Container();
  }
}
