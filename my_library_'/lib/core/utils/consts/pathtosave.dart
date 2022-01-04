import 'package:my_library/data/repository/auth/signed_user.dart';

abstract class PathToSave {
  static final _path = 'users/${SignedUser.getUser()!.uid}/categories';
  static String get getMainPath => _path;
}
