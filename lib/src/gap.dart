import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// created by devin
/// 2022/2/17 17:41
/// description: 
class Gap {

  static Widget h(double h) => SizedBox(height: h,);

  static Widget w(double w) => SizedBox(width: w,);

  static Widget get defaultH => h(30.h);

  static Widget get defaultW => w(30.w);
}
