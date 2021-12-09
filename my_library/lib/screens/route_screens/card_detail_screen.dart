import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/controllers/add_screen_controller.dart';
import 'package:my_library/models/my_card.dart';
import 'package:intl/intl.dart';
import 'package:my_library/res/pop_up_menu_constants.dart';

class CardDetailScreen extends GetView<AddCardScreenController> {
  @override
  Widget build(BuildContext context) {
    MyCard card = Get.arguments;

    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Obx(
      () => Stack(children: [
        GestureDetector(
          onTap: () => controller.undisplayImage(),
          child: Opacity(
            opacity: controller.isImageClicked.value ? 0.45 : 1,
            child: Column(children: [
              Container(
                //AppBar
                height: AppBar().preferredSize.height,
                width: MediaQuery.of(context).size.width,
                color: context.theme.scaffoldBackgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Get.back();
                            }),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            DateFormat.yMMMEd().format(card.dateTime!),
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    PopupMenuButton<int>(
                      enabled: !controller.isImageClicked.value,
                      onSelected: (item) => card.deleteTheCard(),
                      itemBuilder: (context) => PopUpMenuConstants.choices
                          .map((choice) =>
                              PopupMenuItem<int>(child: Text(choice)))
                          .toList(),
                    ),
                  ],
                ),
              ),
              card.title!.value.isEmpty &&
                      card.shortExp!.value.isEmpty &&
                      card.longExp!.value.isEmpty
                  ? Expanded(
                      child: card.images.length > 1
                          ? SizedBox(
                              height: 250,
                              child: Obx(
                                () => ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: card.images
                                      .map(
                                        (element) => GestureDetector(
                                          onTap: () =>
                                              controller.displayImage(element),
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              Container(
                                                height: 250,
                                                child: element,
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            )
                          : Center(
                              child: Container(
                                child: card.images.first,
                              ),
                            ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        card.title!.value.isNotEmpty ||
                                card.shortExp!.value.isNotEmpty ||
                                card.longExp!.value.isNotEmpty
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 1,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: Container(
                                          child: textForCard(
                                              card.title!.value, context),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1)),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 1,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                        Column(
                          children: [
                            Center(
                              child: SizedBox(
                                height: 250,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: card.images
                                      .map(
                                        (element) => Row(
                                          children: [
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            GestureDetector(
                                              onTap: () => controller
                                                  .displayImage(element),
                                              child: Container(
                                                height: 250,
                                                child: element,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            )
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        card.shortExp!.value.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Container(
                                  child: textForCard(
                                      card.shortExp!.value, context),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: Colors.black, width: 1)),
                                ),
                              )
                            : Container(),
                        card.longExp!.value.isNotEmpty
                            ? textForCard(card.longExp!.value, context)
                            : Container(),
                      ],
                    ),
            ]),
          ),
        ),
        controller.isImageClicked.value
            ? Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                top: 0,
                child: Center(
                  child: InteractiveViewer(
                    child: SizedBox(
                      height: size.height * 0.6,
                      width: size.width * 0.7,
                      child: Container(
                        child: controller.selectedImage,
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
      ]),
    ));
  }

  Padding textForCard(String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
