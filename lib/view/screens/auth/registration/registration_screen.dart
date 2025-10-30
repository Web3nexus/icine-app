import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icine/view/components/buttons/rounded_loading_button.dart';

import '../../../../constants/my_strings.dart';
import '../../../../core/route/route.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_images.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/utils/util.dart';
import '../../../../data/controller/auth/auth/signup_controller.dart';
import '../../../../data/repo/auth/general_setting_repo.dart';
import '../../../../data/repo/auth/signup_repo.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/auth_image.dart';
import '../../../components/buttons/circle_button_with_icon.dart';
import '../../../components/custom_back_support_appbar.dart';
import '../../../components/bg_widget/bg_image_widget.dart';
import '../../../components/custom_text_field.dart';
import '../../../components/custom_text_field_for_phone.dart';
import '../../../components/from_errors.dart';
import '../../../components/buttons/rounded_button.dart';
import '../../../components/text_field_container2.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  void initState() {
    MyUtil.changeTheme();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(
        apiClient: Get.find(), sharedPreferences: Get.find()));
    Get.put(SignupRepo(apiClient: Get.find()));
    Get.put(SignUpController(
        signupRepo: Get.find(), sharedPreferences: Get.find()));
    super.initState();
  }

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MyBgWidget(),
        GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            backgroundColor: const Color(0xff4a7ffc),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(AppBar().preferredSize.height),
              child: CustomBackSupportAppBar(
                title: MyStrings.signUp,
                press: () {
                  Get.find<SignUpController>().clearAllData();
                  Get.offAndToNamed(RouteHelper.loginScreen);
                },
              ),
            ),
            body: GetBuilder<SignUpController>(
              builder: (controller) => SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * .02),
                    const AuthImageWidget(),
                    SizedBox(height: MediaQuery.of(context).size.height * .05),

                    /// --------------- Social Buttons -----------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (Platform.isAndroid)
                          Expanded(
                            child: SocialLoginButton(
                              bg: MyColor.gmailColor,
                              text: MyStrings.google,
                              press: () {
                                controller.signInWithGoogle();
                              },
                              imageSize: 30,
                              fromAsset: true,
                              isIcon: false,
                              padding: 0,
                              circleSize: 30,
                              imageUrl: MyImages.gmailIcon,
                            ),
                          ),
                        const SizedBox(width: Dimensions.space15),
                        Expanded(
                          child: SocialLoginButton(
                            bg: MyColor.fbColor,
                            text: MyStrings.facebook,
                            press: () {
                              controller.signInWithFacebook();
                            },
                            imageSize: 30,
                            isIcon: false,
                            fromAsset: true,
                            padding: 0,
                            circleSize: 30,
                            imageUrl: MyImages.fbIcon,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .02),

                    /// --------------- Divider -----------------
                    Row(
                      children: [
                        const Expanded(
                            child: Divider(
                                color: MyColor.textColor, thickness: 1.2)),
                        const SizedBox(width: 10),
                        Text(MyStrings.or.tr),
                        const SizedBox(width: 10),
                        const Expanded(
                            child: Divider(
                                color: MyColor.textColor, thickness: 1.2)),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .02),

                    /// --------------- Username -----------------
                    CustomTextField(
                      fillColor: MyColor.textFiledFillColor,
                      controller: controller.userNameController,
                      focusNode: controller.userNameFocusNode,
                      inputType: TextInputType.text,
                      nextFocus: controller.emailFocusNode,
                      hintText: MyStrings.userName,
                      maxLines: 1,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          controller.removeError(
                              error: MyStrings.kUserNameNullError);
                        } else {
                          controller.addError(
                              error: MyStrings.kUserNameNullError);
                        }

                        if (value.length < 6) {
                          controller.addError(
                              error: MyStrings.kShortUserNameError);
                        } else {
                          controller.removeError(
                              error: MyStrings.kShortUserNameError);
                        }
                      },
                    ),
                    const SizedBox(height: 10),

                    /// --------------- Email -----------------
                    CustomTextField(
                      fillColor: MyColor.textFiledFillColor,
                      controller: controller.emailController,
                      focusNode: controller.emailFocusNode,
                      hintText: MyStrings.email,
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          controller.removeError(
                              error: MyStrings.kEmailNullError);
                        } else {
                          controller.addError(
                              error: MyStrings.kEmailNullError);
                        }

                        if (MyStrings.emailValidatorRegExp.hasMatch(value)) {
                          controller.removeError(
                              error: MyStrings.kInvalidEmailError);
                        } else {
                          controller.addError(
                              error: MyStrings.kInvalidEmailError);
                        }
                      },
                    ),
                    const SizedBox(height: 10),

                    /// --------------- Country picker -----------------
                    TextFieldContainer2(
                      fillColor: MyColor.textFiledFillColor,
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          countryListTheme: CountryListThemeData(
                            inputDecoration: InputDecoration(
                              labelText: MyStrings.search.tr,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 22),
                              disabledBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                                borderSide:
                                    BorderSide(width: 1, color: MyColor.gbr),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(
                                    width: 1, color: MyColor.primaryColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                                borderSide:
                                    BorderSide(width: 1, color: MyColor.gbr),
                              ),
                              errorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.red)),
                              focusedErrorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.red)),
                              isDense: true,
                              hintText: MyStrings.search.tr,
                              hintStyle: mulishSemiBold.copyWith(
                                  color: MyColor.textColor),
                              labelStyle: mulishSemiBold.copyWith(
                                  color: MyColor.textColor),
                              fillColor: MyColor.transparentColor,
                              filled: true,
                            ),
                          ),
                          showPhoneCode: true,
                          onSelect: (Country country) {
                            controller.countryController.text = country.name;
                            controller.setCountryNameAndCode(
                              country.name,
                              country.countryCode,
                              country.phoneCode,
                            );
                          },
                        );
                      },
                      child: CustomTextField(
                        inputType: TextInputType.phone,
                        isEnabled: false,
                        fillColor: MyColor.textFiledFillColor,
                        isShowSuffixIcon: true,
                        isCountryPicker: true,
                        isIcon: true,
                        controller: controller.countryController,
                        hintText: MyStrings.pickACountry,
                        onChanged: (_) {},
                      ),
                    ),
                    if (controller.countryName != null) ...[
                      const SizedBox(height: 10),
                      TextFieldContainer2(
                        fillColor: MyColor.textFiledFillColor,
                        isShowSuffixView: true,
                        prefixWidgetValue:
                            '+${controller.mobileCode ?? ' '}',
                        onTap: () {},
                        child: CustomTextFieldForPhone(
                          controller: controller.mobileController,
                          focusNode: controller.mobileFocusNode,
                          inputType: TextInputType.phone,
                          fillColor: MyColor.textFiledFillColor,
                          hintText: MyStrings.phoneNumber,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              controller.removeError(
                                  error: MyStrings.kPhoneNumberNullError);
                            } else {
                              controller.addError(
                                  error: MyStrings.kPhoneNumberNullError);
                            }
                          },
                        ),
                      ),
                    ],
                    const SizedBox(height: 10),

                    /// --------------- Password -----------------
                    CustomTextField(
                      controller: controller.passwordController,
                      focusNode: controller.passwordFocusNode,
                      nextFocus: controller.confirmPasswordFocusNode,
                      hintText: MyStrings.password,
                      isShowSuffixIcon: true,
                      isPassword: true,
                      fillColor: MyColor.textFiledFillColor,
                      inputType: TextInputType.text,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          controller.removeError(
                              error: MyStrings.kPassNullError);
                        } else {
                          controller.addError(
                              error: MyStrings.kPassNullError);
                        }

                        if (controller.isValidPassword(
                            controller.passwordController.text)) {
                          controller.removeError(
                              error: MyStrings.kInvalidPassError);
                        } else {
                          controller.addError(
                              error: MyStrings.kInvalidPassError);
                        }
                      },
                    ),
                    const SizedBox(height: 10),

                    /// --------------- Confirm Password -----------------
                    CustomTextField(
                      fillColor: MyColor.textFiledFillColor,
                      controller: controller.cPasswordController,
                      focusNode: controller.confirmPasswordFocusNode,
                      inputAction: TextInputAction.done,
                      isPassword: true,
                      hintText: MyStrings.confirmPassword,
                      isShowSuffixIcon: true,
                      onChanged: (value) {
                        if (controller.passwordController.text.isEmpty) {
                          return;
                        } else if (controller.passwordController.text ==
                            value) {
                          controller.removeError(
                              error: MyStrings.kMatchPassError);
                        } else {
                          controller.addError(
                              error: MyStrings.kMatchPassError);
                        }
                      },
                    ),
                    const SizedBox(height: 10),

                    /// --------------- Terms & Conditions -----------------
                    if (controller.needAgree)
                      Row(
                        children: [
                          Checkbox(
                            side: WidgetStateBorderSide.resolveWith(
                              (states) =>
                                  const BorderSide(width: 2, color: Colors.white),
                            ),
                            activeColor: MyColor.primaryColor,
                            value: controller.agreeTC,
                            onChanged: (_) {
                              controller.updateAgreeTC();
                            },
                          ),
                          Flexible(
                            child: Text.rich(
                              TextSpan(
                                text: '${MyStrings.iAgreeWith.tr} ',
                                style: mulishRegular,
                                children: [
                                  TextSpan(
                                    text: MyStrings.policies.tr,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.toNamed(
                                            RouteHelper.privacyScreen);
                                      },
                                    style: mulishBold.copyWith(
                                      color: Colors.red,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 10),

                    /// --------------- Error list + Submit -----------------
                    FormError(errors: controller.errors),
                    const SizedBox(height: 20),
                    controller.isLoading
                        ? const RoundedLoadingButton()
                        : RoundedButton(
                            text: MyStrings.submit,
                            press: () {
                              controller.signUpUser();
                            },
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
