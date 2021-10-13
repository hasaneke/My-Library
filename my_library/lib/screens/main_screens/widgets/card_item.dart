import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/models/my_card.dart';
import 'package:intl/intl.dart';

class CardItem extends StatelessWidget {
  MyCard card;
  CardItem(this.card);

  @override
  Widget build(BuildContext context) {
    final card_controller = Get.put(card, tag: card.path);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      elevation: 5,
      child: ListTile(
        leading: const Icon(
          Icons.airplanemode_off_sharp,
          size: 35,
        ),
        title: Text(
          card_controller.title!.value,
          style: context.textTheme.bodyText1,
        ),
        subtitle: card.shortExp!.value != ''
            ? Text(
                card_controller.shortExp!.value,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.subtitle1,
              )
            : null,
        trailing: Text(
          DateFormat.yMMMEd().format(card_controller.dateTime),
          style: context.textTheme.overline,
        ),
      ),
    );
  }
}
