import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// created by devin
/// 2022/1/27 16:25
/// description:
class TextPortrait extends StatelessWidget {
  const TextPortrait({
    Key? key,
    required this.text,
    this.color,
    this.width = 46,
    this.height = 46,
  }) : super(key: key);

  final String text;
  final Color? color;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 60.sp,
        ),
      ),
    );
  }
}
