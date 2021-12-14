import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/constants/app/app_constants.dart';
import 'core/init/cache/locale_manager.dart';
import 'core/init/lang/language_manager.dart';
import 'core/init/navigation/navigation_route.dart';
import 'core/init/navigation/navigation_service.dart';
import 'view/splash/view/splash_view.dart';

void main() async {
  await init();

  runApp(EasyLocalization(
    supportedLocales: LanguageManager.instance.supportedLocales,
    path: ApplicationConstants.langAssetPath,
    startLocale: LanguageManager.instance.appLocale,
    fallbackLocale: LanguageManager.instance.enLocale,
    child: const MyApp(),
  ));
}

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await LocaleManager.preferencesInit();
  await EasyLocalization.ensureInitialized();
  //TODO disable logs
  EasyLocalization.logger.enableBuildModes = [];
  //await DeviceUtility.instance.initPackageInfo();

  //await Firebase.initializeApp();
  //FirebaseMessaging.onBackgroundMessage(_messageHandler);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
        //primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
      //navigatorObservers: [AnalyticsManager.instance.observer],
    );
  }
}
