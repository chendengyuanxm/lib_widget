import 'package:flutter/material.dart';
import 'package:lib_widget/src/oval_portrait.dart';

class StackedImageRow extends StatelessWidget {
  final List<Widget> images;
  final double size;
  final double borderWidth;
  final Color borderColor;
  final double indent;

  const StackedImageRow({
    Key? key,
    required this.images,
    this.size = 50,
    this.borderWidth = 0,
    this.borderColor = Colors.white,
    this.indent = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return images.length == 0 ? SizedBox() : Stack(
      children: images.map((e) {
        double paddingLeft = (size - indent)*index ++;
        return Padding(
          padding: EdgeInsets.only(left: paddingLeft),
          child: OvalPortrait(
            size: size,
            borderWidth: borderWidth,
            borderColor: borderColor,
            child: e,
          ),
        );
      }).toList(),
    );
  }
}
