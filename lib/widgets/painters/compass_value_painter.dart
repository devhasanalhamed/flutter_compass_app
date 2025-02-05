import 'dart:math';

import 'package:flutter/material.dart';

class CompassValuePainter extends CustomPainter {
  final int majorTickerCount;
  final int minorTickerCount;
  final CardinalityMap cardinalityMap;

  CompassValuePainter({
    this.majorTickerCount = 18,
    this.minorTickerCount = 90,
    this.cardinalityMap = const {0: 'N', 90: 'E', 180: 'S', 270: 'W'},
  });
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;


  List<double> layoutScale(int visuals) {
    final scale = 360 / visuals;
    return List.generate(visuals, (index) => index * scale);
  }

  double correctAngle(double angle) => angle - 90;
}

typedef CardinalityMap = Map<num, String>;

extension on num {
  double toRadians() => this * pi / 180;
}
