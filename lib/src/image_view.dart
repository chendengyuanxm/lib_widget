import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final String? type;
  final String image;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const ImageView.asset(asset, {
    Key? key,
    this.width,
    this.height,
    this.fit,
  }) :  type = 'asset',
        image = asset ?? '',
        super(key: key);

  const ImageView.network(url, {
    Key? key,
    this.width,
    this.height,
    this.fit,
  }) :  type = 'network',
        image = url ?? '',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget imageV;
    if (type == 'network') {
      imageV = CachedNetworkImage(
        imageUrl: image,
        width: width,
        height: height,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        ),
        progressIndicatorBuilder: (BuildContext context, String url, progress,) {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              // value: loadingProgress.expectedTotalBytes != null
              //     ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
              //     : null,
            ),
          );
        },
        errorWidget: (context, error, stacktrace) {
          print('load image error: $stacktrace');
          return Container(
            width: width,
            height: height,
            color: Color(0xFFF4F4F4),
          );
        },
      );
    } else if (type == 'asset') {
      imageV = Image.asset(image,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stacktrace) => Container(
          width: width,
          height: height,
          color: Color(0xFFF4F4F4),
        ),
      );
    } else {
      imageV = Container();
    }

    return imageV;
  }
}
