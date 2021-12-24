import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:my_library/core/utils/routers/app_pages.dart';
import 'package:my_library/core/utils/theme/themes.dart';
import 'package:my_library/presentation/pages/entrance/controller/auth_controller.dart';

import 'package:flutter/services.dart';

import 'core/utils/translations/translation_keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  var authController = Get.put(AuthController());

  runApp(
    GetMaterialApp(
      translationsKeys: AppTranslation.translationKeys,
      locale: const Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      initialRoute:
          authController.user.value == null ? AppPages.INITIAL : Routes.HOME,
      getPages: AppPages.routes,
      theme: Themes.limetheme,
    ),
  );
}
