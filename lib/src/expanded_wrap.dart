import 'package:flutter/material.dart';

class ExpandedWrap extends StatelessWidget {

  const ExpandedWrap({
    Key? key,
    this.padding: const EdgeInsets.all(0),
    this.child,
  }) : super(key: key);

  final EdgeInsetsGeometry padding;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

}