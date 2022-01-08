import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_library/presentation/domain/usecases/togglemark_mycard.dart';

class MyCard extends GetxController {
  String path;
  String containerCatPath;
  RxString? title;
  RxString? shortExp;
  RxString? longExp;

  Map<String, File>? imageFiles = RxMap<String, File>({});
  Map<String, File>? otherFiles = RxMap<String, File>({});

  RxBool? isMarked = RxBool(false);
  DateTime date;
  MyCard({
    required this.path,
    required this.containerCatPath,
    this.title,
    this.shortExp,
    this.longExp,
    this.isMarked,
    required this.date,
  });
  Map<String, dynamic> get toDoc {
    return {
      'title': title!.value,
      'shortExp': shortExp!.value,
      'longExp': longExp!.value,
      'isMarked': isMarked!.value,
      'date': date.toString(),
    };
  }

  static MyCard docToMyCard(
      String containerCatPath, QueryDocumentSnapshot doc) {
    return MyCard(
      path: doc.reference.path,
      containerCatPath: containerCatPath,
      title: RxString(doc.get('title')),
      shortExp: RxString(doc.get('shortExp')),
      longExp: RxString(doc.get('longExp')),
      date: DateTime.parse(doc.get('date')),
      isMarked: RxBool(doc.get('isMarked')),
    );
  }

  toggleMark() {
    isMarked!.value = !isMarked!.value;
    ToggleMarkCard.toggleMarkMyCard(this);
  }
}
