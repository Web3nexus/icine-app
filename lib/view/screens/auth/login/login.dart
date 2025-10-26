import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:Icine/core/utils/my_images.dart';
import 'package:Icine/view/components/auth_image.dart';
import 'package:Icine/view/components/buttons/circle_button_with_icon.dart';
import 'package:Icine/view/components/buttons/rounded_loading_button.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../constants/my_strings.dart';
import '../../../../core/route/route.dart';
import '../../../../core/utils/styles.dart';
import '../../../../data/controller/auth/login_controller.dart';
import '../../../../data/repo/auth/login_repo.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/buttons/rounded_button.dart';
import '../../../components/custom_text_form_field.dart';
import '.././../../../core/utils/dimensions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool b = false;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: MyColor.transparentColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: MyColor.colorBlack,
        systemNavigationBarIconBrightness: Brightness.light));

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
    Get.put(LoginController(loginRepo: Get.find()));

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
    ));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      b = true;
      Get
          .find<LoginController>()
          .isLoading = false;
      Get
          .find<LoginController>()
          .remember = false;
    });
  }

  @override
  void dispose() {
    b = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xff4a7ffc),
      body: GetBuilder<LoginController>(
        builder: (auth) =>
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Stack(
                children: [
                  // const MyBgWidget(image: MyImages.bgImage,),
                  SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20, top: 10),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * .09,
                            ),
                            const AuthImageWidget(),
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * .06,
                            ),
                            InputTextFieldWidget(
                                fillColor: Colors.grey[600]!.withOpacity(0.3),
                                hintTextColor: Colors.white,
                                controller: auth.emailController,
                                hintText: MyStrings.enterUserNameOrEmail),
                            const SizedBox(
                              height: 5,
                            ),
                            InputTextFieldWidget(
                                fillColor: Colors.grey[600]!.withOpacity(0.3),
                                hintTextColor: Colors.white,
                                isPassword: true,
                                controller: auth.passwordController,
                                isAddMargin: false,
                                hintText: MyStrings.enterYourPassword_),

                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 23,
                                        width: 23,
                                        child: Checkbox(
                                            materialTapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                            side: WidgetStateBorderSide
                                                .resolveWith((
                                                states) => const BorderSide(
                                                width: 1.0,
                                                color: Colors.white),),
                                            activeColor: MyColor.primaryColor,
                                            value: auth.remember,
                                            onChanged: (value) {
                                              auth.changeRememberMe();
                                            }),
                                      ),
                                      const SizedBox(width: 5),
                                      Flexible(
                                        child: Text(
                                          MyStrings.rememberMe.tr,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          style: mulishSemiBold.copyWith(
                                              color: MyColor.colorWhite,
                                              fontSize: Dimensions.fontDefault),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                          RouteHelper.forgetPasswordScreen);
                                    },
                                    child: Text(
                                      MyStrings.forgetYourPassword.tr,
                                      textAlign: TextAlign.end,
                                      overflow: TextOverflow.ellipsis,
                                      style: mulishSemiBold.copyWith(
                                          color: Colors.red,
                                          fontSize: Dimensions.fontDefault,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            auth.isLoading
                                ? const Center(
                                child: RoundedLoadingButton())
                                : RoundedButton(
                              color: Colors.red,
                              press: () {
                                if (formKey.currentState!.validate()) {
                                  auth.changeIsLoading();
                                  auth.loginUser(auth.emailController.text,
                                      auth.passwordController.text);
                                }
                              },
                              text: MyStrings.signIn,
                            ),
                            !auth.isAllSocialAuthDisable() ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * .02,),
                                Row(
                                  children: [
                                    const Expanded(child: Divider(
                                        color: MyColor.textColor,
                                        thickness: 1.2),),
                                    const SizedBox(width: 10,),
                                    Text(MyStrings.or.tr),
                                    const SizedBox(width: 10,),
                                    const Expanded(child: Divider(
                                        color: MyColor.textColor,
                                        thickness: 1.2)),
                                  ],
                                ),
                                SizedBox(height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * .02,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Platform.isAndroid &&
                                        auth.isSingleSocialAuthEnable(
                                            isGoogle: true) ? Expanded(
                                      child: SocialLoginButton(
                                        textColor: Colors.white,
                                        bg: MyColor.gmailColor,
                                        text: MyStrings.google,
                                        press: () {
                                          auth.signInWithGoogle();
                                        },
                                        imageSize: 30,
                                        fromAsset: true,
                                        isIcon: false,
                                        padding: 0,
                                        circleSize: 30,
                                        imageUrl: MyImages.gmailIcon,),
                                    ) : const SizedBox.shrink(),
                                    const SizedBox(width: Dimensions.space15),
                                    auth.isSingleSocialAuthEnable(
                                        isGoogle: false)
                                        ? Expanded(child: SocialLoginButton(
                                        bg: MyColor.fbColor,
                                        text: MyStrings.facebook,
                                        press: () {
                                          auth.signInWithFacebook();
                                        },
                                        imageSize: 30,
                                        isIcon: false,
                                        fromAsset: true,
                                        padding: 0,
                                        circleSize: 30,
                                        imageUrl: MyImages.fbIcon))
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                              ],
                            ) : const SizedBox.shrink(),
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * .085,
                            ),
                            Center(
                              child: Text(
                                MyStrings.notAccount.tr,
                                style: mulishSemiBold.copyWith(
                                    color: MyColor.colorWhite,
                                    fontSize: Dimensions.fontLarge),
                              ),
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Get.offAndToNamed(
                                      RouteHelper.registrationScreen);
                                },
                                child: Text(
                                  MyStrings.signUp.tr,
                                  style: mulishBold.copyWith(
                                    fontSize: 18, color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: MediaQuery
                                .of(context)
                                .size
                                .height * .06,),
                            InkWell(
                              splashColor: MyColor.primaryColor,
                              hoverColor: MyColor.primaryColor,
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                auth.clearAllSharedData();
                                Get.toNamed(RouteHelper.homeScreen);
                              },
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.transparent,
                                    border: Border.all(
                                        color: MyColor.textFieldColor,
                                        width: 2),
                                  ),
                                  child: Text(MyStrings.asAGuest.tr,
                                    style: mulishSemiBold.copyWith(
                                        color: MyColor.colorWhite),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }

}
