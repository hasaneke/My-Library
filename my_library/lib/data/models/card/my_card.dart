import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_library/data/models/card/files/fire_image_file.dart';
import 'package:my_library/data/models/card/files/fire_other_file.dart';
import 'package:my_library/data/repository/firebase_storage/fetch_files_firebasestorage.dart';

import 'package:my_library/domain/usecases/mycard/togglemark_mycard.dart';

class MyCard extends GetxController {
  String path;
  String containerCatPath;
  RxString? title;
  RxString? shortExp;
  RxString? longExp;
  RxBool? isMarked = RxBool(false);
  DateTime date;
  bool isFetched = false;
  RxList<FireImageFile> fireImageFileList = RxList([]);
  RxList<FireOtherFile> fireOtherFileList = RxList([]);

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

  fetchFiles() async {
    fireImageFileList.value = await FetchFilesFirebaseStorage.fetchImages(path);
    fireOtherFileList.value =
        await FetchFilesFirebaseStorage.fetchOtherFiles(path);
  }

  toggleMark() {
    isMarked!.value = !isMarked!.value;
    ToggleMarkCard.toggleMarkMyCard(this);
  }
}
