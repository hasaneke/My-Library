import 'package:my_library/core/utils/consts/signed_user.dart';

abstract class PathToSave {
  static final _path = 'users/${SignedUser.getUser()!.uid}/categories';
  static String get getMainPath => _path;
}
