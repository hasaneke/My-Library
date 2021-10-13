import 'package:get/get.dart';

class MyCard extends GetxController {
  String? path; //Path to item<
  //var imagesUrl = RxList<String>([]);

  RxString? title;
  RxString? shortExp;
  RxString? longExp;
  RxBool? isFavorite = false.obs;
  DateTime dateTime;
  MyCard(
      {this.path,
      //required this.imagesUrl,
      this.title,
      this.shortExp,
      this.longExp,
      this.isFavorite,
      required this.dateTime});

  void changeTheItem(MyCard item) {
    title!.value = item.title!.value;
    shortExp!.value = item.shortExp!.value;
    longExp!.value = item.longExp!.value;
  }

  void toggleFavorite() {
    isFavorite!.value = isFavorite!.value;
  }

  void deleteTheImage(String imageUrl) {
    //imagesUrl.remove(imageUrl);
  }
}
