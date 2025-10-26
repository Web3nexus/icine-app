import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:Icine/core/utils/my_color.dart';
import 'package:Icine/core/utils/dimensions.dart';
import 'package:Icine/core/utils/styles.dart';

class FormError extends StatelessWidget {
  const FormError({
    super.key,
    required this.errors,
  });

  final List<String?> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors.length, (index) => formErrorText(error: errors[index]!)),
    );
  }

  Padding formErrorText({required String error}) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/images/error.svg",
            height: 16,
            width: 16,
          ),
         const SizedBox(
            width: 10,
          ),
          Text(error.tr,style: mulishLight.copyWith(color: MyColor.colorWhite,fontSize: Dimensions.fontSmall),),
        ],
      ),
    );
  }
}