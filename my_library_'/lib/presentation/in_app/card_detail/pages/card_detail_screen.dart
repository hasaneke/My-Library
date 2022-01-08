import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_library/core/utils/popupmenu/pop_up_menu_constants.dart';
import 'package:my_library/data/models/card/my_card.dart';
import 'package:my_library/presentation/in_app/card_detail/controller/card_detail_controller.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class CardDetailScreen extends GetView<CardDetailController> {
  MyCard myCard = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.assignedCard = myCard;
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Obx(
      () => Stack(children: [
        GestureDetector(
          onTap: () => controller.undisplayTappedImage(),
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
                            DateFormat.yMMMEd().format(myCard.date),
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              controller.toggleMark();
                            },
                            icon: Obx(() => Icon(myCard.isMarked!.value
                                ? Icons.bookmark
                                : Icons.bookmark_border_outlined))),
                        PopupMenuButton<String>(
                          enabled: !controller.isImageClicked.value,
                          onSelected: (choice) =>
                              controller.onPopUpSelected(choice),
                          itemBuilder: (context) => PopUpMenuConstants.choices
                              .map((choice) => PopupMenuItem<String>(
                                  value: choice, child: Text(choice)))
                              .toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              myCard.title!.value.isEmpty &&
                      myCard.shortExp!.value.isEmpty &&
                      myCard.longExp!.value.isEmpty
                  ? Expanded(
                      child: myCard.imageFiles!.length > 1
                          ? SizedBox(
                              height: 250,
                              child: Obx(
                                () => ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: myCard.imageFiles!.values
                                      .map(
                                        (imageFile) => GestureDetector(
                                          onTap: () => controller
                                              .displayTappedImage(imageFile),
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              SizedBox(
                                                height: 250,
                                                child: Image.file(imageFile),
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
                              child: myCard.imageFiles!.values.isNotEmpty
                                  ? Image.file(myCard.imageFiles!.values.first)
                                  : Container(),
                            ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        myCard.title!.value.isNotEmpty ||
                                myCard.shortExp!.value.isNotEmpty ||
                                myCard.longExp!.value.isNotEmpty
                            ? SizedBox(
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
                                              myCard.title!.value, context),
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
                                  children: myCard.imageFiles!.values
                                      .map(
                                        (file) => Row(
                                          children: [
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            GestureDetector(
                                              onTap: () => controller
                                                  .displayTappedImage(file),
                                              child: SizedBox(
                                                height: 250,
                                                child: Image.file(file),
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
                        myCard.shortExp!.value.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Container(
                                  child: textForCard(
                                      myCard.shortExp!.value, context),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: Colors.black, width: 1)),
                                ),
                              )
                            : Container(),
                        myCard.longExp!.value.isNotEmpty
                            ? textForCard(myCard.longExp!.value, context)
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
                        child: controller.tappedImage,
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
