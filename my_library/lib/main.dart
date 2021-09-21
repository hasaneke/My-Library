import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/controllers/auth_controller.dart';
import 'package:my_library/res/translation_keys.dart';
import 'package:my_library/routes/app_pages.dart';
import 'package:my_library/res/themes.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  var authController = Get.put(AuthController());

  runApp(
    GetMaterialApp(
      translationsKeys: AppTranslation.translationKeys,
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      initialRoute:
          authController.user.value == null ? AppPages.INITIAL : Routes.HOME,
      getPages: AppPages.routes,
      theme: Themes.limetheme,
    ),
  );
}
