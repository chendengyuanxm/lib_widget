import 'package:flutter/material.dart';

class VerticalText extends CustomPainter {
  String text;
  double width;
  double height;
  TextStyle? textStyle;

  VerticalText(this.text, {this.textStyle, this.width = 0, this.height = 100});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = new Paint();
    paint.color = textStyle?.color ?? Colors.black;
    double offsetX = width;
    double offsetY = 0;
    bool newLine = true;
    double maxWidth = 0;

    maxWidth = findMaxWidth(text, textStyle);

    text.runes.forEach((rune) {
      String str = new String.fromCharCode(rune);
      TextSpan span = new TextSpan(style: textStyle, text: str);
      TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
      tp.layout();

      if (offsetY + tp.height > height) {
        newLine = true;
        offsetY = 0;
      }

      if (newLine) {
        offsetX -= maxWidth;
        newLine = false;
      }

      if (offsetX < -maxWidth) {
        return;
      }

      tp.paint(canvas, new Offset(offsetX, offsetY));
      offsetY += tp.height;
    });
  }

  double findMaxWidth(String text, TextStyle? style) {
    double maxWidth = 0;

    text.runes.forEach((rune) {
      String str = new String.fromCharCode(rune);
      TextSpan span = new TextSpan(style: style, text: str);
      TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
      tp.layout();
      maxWidth = max(maxWidth, tp.width);
    });

    return maxWidth;
  }

  @override
  bool shouldRepaint(VerticalText oldDelegate) {
    return oldDelegate.text != text || oldDelegate.textStyle != textStyle || oldDelegate.width != width || oldDelegate.height != height;
  }

  double max(double a, double b) {
    if (a > b) {
      return a;
    } else {
      return b;
    }
  }
}
