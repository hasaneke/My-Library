import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_library/data/models/MyCard/my_card.dart';
import 'package:my_library/data/repositories/database.dart';

class MarkedScreenController extends GetxController {
  RxList<MyCard> _markedCards = RxList<MyCard>([]);

  List<MyCard> get markedCards => _markedCards;

  void addCardToMarkedList(MyCard myCard) {
    _markedCards.add(myCard);
  }

  void removeCardFromMarkedList(MyCard myCard) {
    _markedCards.remove(myCard);
  }

  @override
  void onInit() {
    log('?');
    DatabaseController database = Get.find<DatabaseController>();
    FirebaseFirestore.instance
        .collection('users/${database.userId}/markedCards')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) async {
        String path = element['path'];
        log(path);
        DocumentSnapshot cardDoc =
            await FirebaseFirestore.instance.doc(path).get();
        log(cardDoc['title']);

        var newCard = MyCard(
            path: path,
            containerCatPath: path.split('/card')[0],
            uniqueId: cardDoc['unique_id'],
            title: RxString(cardDoc['title']),
            shortExp: RxString(cardDoc['short_exp']),
            longExp: RxString(cardDoc['long_exp']),
            dateTime: DateTime.parse(cardDoc['date']),
            isMarked: RxBool(cardDoc['is_marked']));
        _markedCards.add(newCard);
        log(newCard.containerCatPath);
      });
    });
    super.onInit();
  }
}
