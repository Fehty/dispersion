import 'dart:ui';

import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  GradientText(this.text, {@required this.gradient, @required this.textStyle});

  final String text;
  final Gradient gradient;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        shaderCallback: (bounds) => gradient
            .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
        child: Text(text, style: textStyle.copyWith(color: Colors.white)));
  }
}
