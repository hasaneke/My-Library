import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/data/models/MyCard/my_card.dart';
import 'package:intl/intl.dart';
import 'package:my_library/utils/routers/app_pages.dart';

// ignore: must_be_immutable
class CardItem extends StatelessWidget {
  MyCard card;
  CardItem(this.card, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyCard controller = Get.put(card, tag: card.path);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      elevation: 5,
      child: Obx(
        () => ListTile(
          onTap: () {
            controller.isFetched
                ? Get.toNamed(Routes.CARD_DETAIL_SCREEN, arguments: card.path)
                : card.fetchImages().then((value) => Get.toNamed(
                    Routes.CARD_DETAIL_SCREEN,
                    arguments: card.path));
          },
          leading: controller.images.isNotEmpty
              ? CircleAvatar(
                  backgroundImage: controller.images.first.image,
                  backgroundColor: Colors.transparent)
              : null,
          title: Text(
            controller.title!.value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodyText2,
          ),
          subtitle: controller.shortExp!.value != ''
              ? Text(
                  controller.shortExp!.value,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.subtitle1,
                )
              : null,
          trailing: Text(
            DateFormat.yMMMEd().format(controller.dateTime!),
            style: context.textTheme.overline,
          ),
        ),
      ),
    );
  }
}
