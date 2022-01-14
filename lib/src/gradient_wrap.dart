import 'package:flutter/material.dart';

class GradientWrap extends StatelessWidget {
  final List<Color>? colors;
  final Widget? child;
  final Alignment begin;
  final Alignment end;
  final List<double>? stops;

  const GradientWrap({
    Key? key,
    this.colors,
    this.begin = Alignment.topCenter,
    this.end = Alignment.bottomCenter,
    this.stops,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors ?? [],
          begin: begin,
          end: end,
          stops: stops,
          tileMode: TileMode.clamp,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: child,
    );
  }
}
