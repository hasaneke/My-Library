import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:my_library/presentation/widgets/card_item.dart';

import 'controller/marked_screen_controller.dart';

class MarkedScreen extends GetView<MarkedScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Icon(
          Icons.bookmark,
          color: Colors.black,
          size: 45,
        ),
        centerTitle: true,
        backgroundColor: context.theme.scaffoldBackgroundColor,
      ),
      body: Obx(() => controller.markedCards.length > 0
          ? ListView.builder(
              itemBuilder: (context, i) => CardItem(controller.markedCards[i]),
              itemCount: controller.markedCards.length,
              shrinkWrap: true,
            )
          : Center(
              child: Text('Empty'),
            )),
    );
  }
}
