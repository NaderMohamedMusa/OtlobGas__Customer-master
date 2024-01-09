import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'core/languages/app_translations.dart';
import 'core/routes/app_pages.dart';
import 'core/services/language_service.dart';
import 'core/theme/theme_manager.dart';
import 'firebase_options.dart';
import 'injector.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "OtlobGas-Customers",
      translationsKeys: AppTranslation.translations,
      //locale: Locale('en'),
      locale: Locale(LanguageService.to.savedLang.value),
      fallbackLocale: const Locale('ar'),
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: applicationTheme,
      debugShowCheckedModeBanner: false,
      //initialRoute: Routes.rating,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
