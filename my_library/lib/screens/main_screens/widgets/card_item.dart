import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/models/my_card.dart';
import 'package:intl/intl.dart';
import 'package:my_library/screens/main_screens/card_detail_screen.dart';

class CardItem extends StatelessWidget {
  MyCard card;
  CardItem(this.card);

  @override
  Widget build(BuildContext context) {
    MyCard controller = Get.put(card, tag: card.path);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      elevation: 5,
      child: Obx(
        () => ListTile(
          onTap: () {
            card.isFetched
                ? Get.to(() => CardDetailScreen(), arguments: card)
                : card.fetchImages().then((value) =>
                    Get.to(() => CardDetailScreen(), arguments: card));
          },
          leading: controller.images.isNotEmpty
              ? CircleAvatar(
                  backgroundImage: card.images.first.image,
                  backgroundColor: Colors.transparent)
              : null,
          title: Text(
            card.title!.value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodyText2,
          ),
          subtitle: card.shortExp!.value != ''
              ? Text(
                  card.shortExp!.value,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.subtitle1,
                )
              : null,
          trailing: Text(
            DateFormat.yMMMEd().format(card.dateTime!),
            style: context.textTheme.overline,
          ),
        ),
      ),
    );
  }
}
