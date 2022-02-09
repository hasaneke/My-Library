import 'package:my_library/data/repository/firebase_firestore/update_category_title_firebase.dart';

class UpdateCategoryTitle {
  static Future<String> updateTitle(String newTitle, String path) async {
    UpdateCategoryTitleFirestoreApi.updateTitleOnFirebase(newTitle, path);
    return newTitle;
  }
}
