import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:icine/core/utils/my_color.dart';
import 'package:icine/core/utils/my_images.dart';

class CustomNetworkImage extends StatelessWidget {
  final double height;
  final double width;
  final String imageUrl;
  final IconData errorImage;
  final BoxFit boxFit;
  final double spinKitSize;
  final int duration;
  final bool isSlider;
  final bool fromSplash;
  final bool sliderOverlay;
  final bool showPlaceHolder;
  final bool showErrorImage;

  const CustomNetworkImage({
    super.key,
    this.height = 110,
    this.width = 320,
    this.fromSplash = false,
    this.duration = 500,
    this.spinKitSize = 30,
    this.isSlider = false,
    this.showPlaceHolder = true,
    this.sliderOverlay = false,
    required this.imageUrl,
    this.boxFit = BoxFit.cover,
    this.errorImage = Icons.error_outline_outlined,
    this.showErrorImage = true,
  });

  @override
  Widget build(BuildContext context) {
    return isSlider
        ? OctoImage(
            height: height,
            width: width,
            colorBlendMode: BlendMode.overlay,
            color: !sliderOverlay ? Colors.transparent : Colors.grey,
            fadeInDuration: Duration(milliseconds: duration),
            image: NetworkImage(imageUrl),
            placeholderBuilder: (context) => Container(
              height: height,
              width: width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black12,
                image: DecorationImage(
                  image: AssetImage(MyImages.errorImage),
                  fit: BoxFit.cover,
                ),
              ),
              child: showPlaceHolder
                  ? Image.asset(
                      MyImages.placeHolderImage,
                      height: 40,
                      width: 40,
                    )
                  : const SizedBox(),
            ),
            errorBuilder: (context, error, stackTrace) => Container(
              height: height,
              width: width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(MyImages.errorImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            fit: boxFit,
          )
        : OctoImage(
            height: height,
            width: width,
            colorBlendMode: BlendMode.overlay,
            color:
                !sliderOverlay ? Colors.transparent : MyColor.colorGrey,
            fadeInDuration: Duration(milliseconds: duration),
            image: NetworkImage(imageUrl),
            placeholderBuilder: (context) => Container(
              height: height,
              width: width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black12,
                image: DecorationImage(
                  image: AssetImage(MyImages.errorImage),
                  fit: BoxFit.cover,
                ),
              ),
              child: showPlaceHolder
                  ? Image.asset(
                      MyImages.placeHolderImage,
                      height: 40,
                      width: 40,
                    )
                  : const SizedBox(),
            ),
            errorBuilder: (context, error, stackTrace) {
              if (showErrorImage) {
                return Container(
                  height: height,
                  width: width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(MyImages.errorImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              } else {
                return Container(
                  height: height,
                  width: width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(MyImages.errorImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    height: height / 3,
                    width: width / 3,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: MyColor.colorBlack,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.lock_outline_rounded,
                      color: MyColor.redCancelTextColor,
                      size: 25,
                    ),
                  ),
                );
              }
            },
            fit: boxFit,
          );
  }
}
