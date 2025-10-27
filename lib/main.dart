import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:Icine/data/controller/localization/localization_controller.dart';
import 'package:Icine/firebase_options.dart';
import 'package:Icine/push_notification_service.dart';

import 'constants/my_strings.dart';
import 'core/di_service/di_service.dart' as di_service;
import 'core/helper/messages.dart';
import 'core/route/route.dart';
import 'core/theme/dark.dart';
import 'core/utils/my_color.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> _messageHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase FIRST before any other Firebase-dependent services
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Now initialize MobileAds (depends on Firebase)
  MobileAds.instance.initialize();

  Map<String, Map<String, String>> languages = await di_service.init();

  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  await PushNotificationService().setupInteractedMessage();

  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: MyColor.colorGrey3,
    // navigation bar color
    statusBarColor: MyColor.secondaryColor,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(MyApp(languages: languages));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;

  const MyApp({super.key, required this.languages});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(builder: (localizeController) {
      return GetMaterialApp(
        title: MyStrings.appName,
        initialRoute: RouteHelper.splashScreen,
        defaultTransition: Transition.topLevel,
        transitionDuration: const Duration(milliseconds: 50),
        getPages: RouteHelper.routes,
        navigatorKey: Get.key,
        theme: dark,
        debugShowCheckedModeBanner: false,
        locale: localizeController.locale,
        translations: Messages(languages: languages),
        fallbackLocale: Locale(localizeController.locale.languageCode,
            localizeController.locale.countryCode),
      );
    });
  }
}
