import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:Icine/core/utils/my_color.dart';
import 'package:Icine/core/utils/my_images.dart';
import 'package:Icine/data/repo/auth/general_setting_repo.dart';
import 'package:Icine/data/repo/splash/splash_repo.dart';
import 'package:Icine/data/services/api_service.dart';
import '../../../core/route/route.dart';


import '../../../data/controller/localization/localization_controller.dart';
import '../../../data/controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SplashRepo(apiClient: Get.find()));
    Get.put(GeneralSettingRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));

    final controller = Get.put(SplashController(
    splashRepo: Get.find(),
    gsRepo: Get.find(),
    localizationController: Get.find(),
    ));

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    try {
      await controller.gotoNextPage().timeout(
        const Duration(seconds: 8),
        onTimeout: () {
          print('⚠️ Splash timeout, going to login');
          Get.offAllNamed(RouteHelper.loginScreen);
        },
      );
    } catch (e) {
      print('💥 Splash init error: $e');
      Get.offAllNamed(RouteHelper.loginScreen);
    }
  });
}


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff4a7ffc),
        body: GetBuilder<SplashController>(
          builder: (controller) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(5),
            child: Center(
              child: Container(
                 height: 200,width: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(MyImages.logo),
                  ),
                )
              ),
            ),
          );
          }),
      ),
    );
  }
}