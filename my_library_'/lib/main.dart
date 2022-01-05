import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:my_library/core/utils/routers/app_pages.dart';
import 'package:my_library/core/utils/theme/themes.dart';
import 'package:my_library/core/utils/translations/translation_keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(GetMaterialApp(
    translationsKeys: AppTranslation.translationKeys,
    locale: const Locale('en', 'US'),
    debugShowCheckedModeBanner: false,
    getPages: AppPages.routes,
    initialRoute: Routes.LOGIN_SCREEN_ROUTE,
    theme: Themes.limetheme,
  ));
}
