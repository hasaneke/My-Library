import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/presentation/in_app/components/my_card_item/my_card_item.dart';
import 'package:my_library/presentation/in_app/tabbar/pages/tabs/all_cards_screen/controller/all_cards_controller.dart';

// ignore: use_key_in_widget_constructors
class AllCardsScreen extends GetView<AllCardsController> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: ScrollController(keepScrollOffset: true),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, index) {
        var card = controller.allCards.elementAt(index);
        return MyCardItem(card);
      },
      itemCount: controller.allCards.length,
    );
  }
}
