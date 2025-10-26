import 'package:flutter/material.dart';
import 'package:Icine/core/utils/my_images.dart';
import '../../../../../core/utils/my_color.dart';

class ProfileWidget extends StatefulWidget {

  final String imagePath;
  final VoidCallback onClicked;
  final bool isEdit;

   const ProfileWidget({super.key,
    required this.imagePath,
    required this.onClicked,
    this.isEdit = false
  });

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          buildImage(),
        ],
      ),
    );
  }

  Widget buildImage() {

    final  Object image;
    image =  const AssetImage(MyImages.profile);

    return ClipOval(
      child: Material(
        color: MyColor.lightOrange,
        child: Ink.image(
          image: image as ImageProvider,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(
            onTap: widget.onClicked,
          ),
        ),
      ),
    );
  }


}

