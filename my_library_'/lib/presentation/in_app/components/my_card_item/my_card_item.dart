import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/core/utils/routers/app_pages.dart';
import 'package:my_library/data/models/card/my_card.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class MyCardItem extends StatelessWidget {
  MyCard myCard;
  // ignore: use_key_in_widget_constructors
  MyCardItem(this.myCard);

  @override
  Widget build(BuildContext context) {
    var myCardController = Get.put(myCard, tag: myCard.path);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      elevation: 5,
      child: Obx(
        () => ListTile(
          onTap: () {
            Get.toNamed(Routes.CARD_DETAIL_SCREEN_ROUTE, arguments: myCard);
          },
          leading: myCardController.imageFiles!.isNotEmpty
              ? CircleAvatar(
                  backgroundImage:
                      Image.file(myCardController.imageFiles!.values.first)
                          .image,
                  backgroundColor: Colors.transparent)
              : null,
          title: Text(
            myCardController.title!.value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodyText2,
          ),
          subtitle: myCardController.shortExp!.value != ''
              ? Text(
                  myCardController.shortExp!.value,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.subtitle1,
                )
              : null,
          trailing: Text(
            DateFormat.yMMMEd().format(myCardController.date),
            style: context.textTheme.overline,
          ),
        ),
      ),
    );
  }
}
