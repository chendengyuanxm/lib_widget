import 'package:flutter/material.dart';

class CustomGestureDetector extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Widget? child;

  const CustomGestureDetector({Key? key, this.onTap, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: child,
    );
  }
}
