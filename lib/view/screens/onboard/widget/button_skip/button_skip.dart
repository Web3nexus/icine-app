import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:Icine/core/utils/dimensions.dart';
import 'package:Icine/core/utils/my_color.dart';
import 'package:Icine/core/utils/styles.dart';
import '../../../../../constants/my_strings.dart';


class ButtonSkip extends StatelessWidget {
  final Callback press;
  const ButtonSkip({super.key,required this.press});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap:press,
          child: Container(
            width: MediaQuery.of(context).size.width ,
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 18),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
              border: Border.all(color: MyColor.borderColor, width: 1.2)),
            child: Text(
             MyStrings.skip.tr,
              style: mulishSemiBold.copyWith(color: MyColor.textColor),
            ),
          ),
        ),
      ),
    );
  }
}
