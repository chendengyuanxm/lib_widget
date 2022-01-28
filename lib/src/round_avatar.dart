import 'package:flutter/material.dart';
import 'package:lib_widget/src/image_view.dart';

class RoundAvatar extends StatelessWidget {
  final String imgUrl;
  final double? width;
  final double? height;
  final double radius;
  final BoxFit? fit;
  final GestureTapCallback? onTap;

  const RoundAvatar(
    this.imgUrl, {
    Key? key,
    this.width,
    this.height,
    this.radius = 10,
    this.fit,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: ImageView.network(
          imgUrl,
          width: width,
          height: height,
          fit: fit,
        ),
      ),
    );
  }
}
