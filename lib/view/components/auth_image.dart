import 'package:flutter/material.dart';

import '../../core/utils/my_images.dart';

class AuthImageWidget extends StatelessWidget {
  const AuthImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(child: Image.asset(MyImages.logo, height: MediaQuery.of(context).size.height * .18,width: MediaQuery.of(context).size.width *.7,fit: BoxFit.fill,));
  }
}
