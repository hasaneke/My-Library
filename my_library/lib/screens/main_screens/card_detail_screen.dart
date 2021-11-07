import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/models/my_card.dart';
import 'package:intl/intl.dart';
import 'package:my_library/res/pop_up_menu_constants.dart';

class CardDetailScreen extends StatelessWidget {
  CardDetailScreen();

  @override
  Widget build(BuildContext context) {
    MyCard card = Get.arguments;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: AppBar().preferredSize.height,
            width: MediaQuery.of(context).size.width,
            color: context.theme.scaffoldBackgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Get.back();
                        }),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        DateFormat.yMMMEd().format(card.dateTime!),
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                PopupMenuButton<int>(
                    itemBuilder: (context) => PopUpMenuConstants.choices
                        .map(
                            (choice) => PopupMenuItem<int>(child: Text(choice)))
                        .toList()),
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
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
                            child: textForCard(card.shortExp!.value, context),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border:
                                    Border.all(color: Colors.black, width: 1)),
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
                ),
                Column(
                  children: [
                    Container(
                      height: 250,
                      child: Obx(
                        () => ListView(
                          scrollDirection: Axis.horizontal,
                          children: card.images
                              .map(
                                (element) => Row(
                                  children: [
                                    Container(
                                      height: 250,
                                      child: element,
                                    ),
                                    SizedBox(
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
                          child: textForCard(card.shortExp!.value, context),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                        ),
                      )
                    : Container(),
                card.longExp!.value.isNotEmpty
                    ? textForCard(card.longExp!.value, context)
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding textForCard(String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
