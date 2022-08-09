import 'package:flutter/material.dart';

/// created by devin
/// 2022/7/21 14:50
/// description:
class CustomGestureDetector extends StatefulWidget {
  const CustomGestureDetector({
    Key? key,
    this.child,
    this.onTap,
  }) : super(key: key);

  final Widget? child;

  final VoidCallback? onTap;

  @override
  State<CustomGestureDetector> createState() => _CustomGestureDetectorState();
}

class _CustomGestureDetectorState extends State<CustomGestureDetector> {
  int _lastTime = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        int _current = DateTime.now().millisecondsSinceEpoch;
        int duration = _current - _lastTime;
        if (duration > 1000) {
          _lastTime = _current;
          widget.onTap?.call();
        }
      },
      child: widget.child,
    );
  }
}
