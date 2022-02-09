import 'package:my_library/data/models/category/my_category.dart';
import 'package:my_library/data/repository/firebase_firestore/delete_category_from_firebase.dart';

class DeleteCategory {
  static Future<void> recrusiveDeletion(MyCategory myCategory) async {
    if (myCategory.subCategories.isNotEmpty) {
      for (var subCat in myCategory.subCategories.values) {
        recrusiveDeletion(subCat);
      }
    }
    myCategory.clearCards();
    DeleteCategoryFromFirebaseApi.deleteCategoryFromFirebaseApi(
        myCategory.path);
  }
}
