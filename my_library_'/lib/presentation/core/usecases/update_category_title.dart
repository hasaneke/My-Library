import 'package:my_library/data/repository/firestore/update_category_title_firebase.dart';

class UpdateCategoryTitle {
  static Future<String> updateTitle(String newTitle, String path) async {
    UpdateCategoryTitleFirebaseApi.updateTitleOnFirebase(newTitle, path);
    return newTitle;
  }
}
