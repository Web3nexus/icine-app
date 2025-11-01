import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icine/constants/my_strings.dart';
import 'package:icine/core/helper/string_format_helper.dart';
import 'package:icine/core/utils/my_color.dart';

class CustomSnackbar {
  static void showCustomSnackbar({
    required List<String> errorList,
    required List<String> msg,
    required bool isError,
    int duration = 5,
  }) {
    String message = '';

    if (isError) {
      message = errorList.isEmpty
          ? MyStrings.unKnownError.tr
          : errorList.join('\n');
    } else {
      message = msg.isEmpty ? MyStrings.success.tr : msg.join('\n');
    }

    message = CustomValueConverter.removeQuotationAndSpecialCharacterFromString(
      message,
    );

    if (message.isEmpty) {
      message = isError
          ? MyStrings.failedToUpdateProfile
          : MyStrings.profileUpdatedSuccessfully;
    }

    Get.rawSnackbar(
      message: message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor:
          isError ? Colors.redAccent : MyColor.greenSuccessColor,
      borderRadius: 12,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(15),
      duration: Duration(seconds: duration),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static void showSnackbarWithoutTitle(
    BuildContext context,
    String message, {
    Color bg = MyColor.greenSuccessColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: bg,
        content: Text(message),
      ),
    );
  }
}
