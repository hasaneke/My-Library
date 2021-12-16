import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_library/bindings.dart';
import 'package:my_library/screens/presentation_screens/controller/auth_controller.dart';
import 'package:my_library/utils/translations/translation_keys.dart';
import 'package:my_library/utils/routers/app_pages.dart';
import 'package:my_library/utils/theme/themes.dart';
import 'package:flutter/services.dart';
import 'package:my_library/utils/routers/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  var authController = Get.put(AuthController());

  runApp(
    GetMaterialApp(
      translationsKeys: AppTranslation.translationKeys,
      locale: Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      initialRoute:
          authController.user.value == null ? AppPages.INITIAL : Routes.HOME,
      getPages: AppPages.routes,
      theme: Themes.limetheme,
    ),
  );
}
