import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:Icine/core/utils/my_color.dart';
import 'package:Icine/core/utils/styles.dart';
import '../../../../../constants/my_strings.dart';


class ButtonNext extends StatelessWidget {
  final Callback press;
  const ButtonNext({super.key,required this.press});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:press,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        width: 50,
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(shape: BoxShape.circle, color: MyColor.primaryColor),
        child: Text(
         MyStrings.next.tr,
          style: mulishSemiBold.copyWith(color: MyColor.colorWhite),
        ),
      ),
    );
  }
}
