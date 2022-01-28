import 'package:flutter/material.dart';

class OvalPortrait extends StatelessWidget {
  final double size;
  final double borderWidth;
  final Color borderColor;
  final Widget? child;

  const OvalPortrait({
    Key? key,
    this.size = 50,
    this.borderWidth = 0,
    this.borderColor = Colors.white,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        border: borderWidth > 0
            ? Border.all(
                color: borderColor,
                width: borderWidth,
              )
            : null,
      ),
      child: ClipOval(
        child: child,
      ),
    );
  }
}
