import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/presentation/in_app/components/my_card_item/my_card_item.dart';
import 'package:my_library/presentation/in_app/tabbar/pages/tabs/marked_cards/controllers/marked_cards_controller.dart';

// ignore: use_key_in_widget_constructors
class MarkedCardsScreen extends GetView<MarkedCardsController> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: ScrollController(keepScrollOffset: true),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, index) {
        var card = controller.markedCards.elementAt(index);
        return MyCardItem(card);
      },
      itemCount: controller.markedCards.length,
    );
  }
}
