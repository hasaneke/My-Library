import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_library/controllers/auth_controller.dart';
import 'package:my_library/models/category.dart';
import 'package:uuid/uuid.dart';

class Database extends GetxController {
  late String _userdId;

  void addCategory(Category category) {
    var uuI = Uuid().v1();
  }

  @override
  void onInit() {
    _userdId = Get.put(AuthController()).user.value!.uid;
    super.onInit();
  }
}
