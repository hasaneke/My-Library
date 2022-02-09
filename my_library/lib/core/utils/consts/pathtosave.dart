import 'package:my_library/data/repository/firebase_auth/signed_user.dart';

class PathToSave {
  var path = 'users/${SignedUser.myUser!.uid}/categories';
  String get getMainPath => path;
}
