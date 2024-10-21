// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:packages_app/core/util/mycolor.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'dart:math';

class LoadingPercentPainter extends CustomPainter {
  final double strokeWidth;
  final double circleRadius;
  final double loadingPercent;
  final Color backColor;
  final List<Color> indicatorGradientColor;
  const LoadingPercentPainter({
    required this.strokeWidth,
    required this.circleRadius,
    required this.loadingPercent,
    this.backColor = MyColor.inActiveColor,
    required this.indicatorGradientColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final h = size.height, w = size.width;
    final gradient1 = SweepGradient(colors: indicatorGradientColor);
    final center = Offset(w / 2, h / 2);
    final rect = Rect.fromCenter(center: center, width: w, height: h);

    // background ash-color circle
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = backColor
      ..strokeWidth = strokeWidth;
    canvas.drawArc(rect, math.radians(270), math.radians(360), false, paint);

    // colorful Circle
    final paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..shader = gradient1.createShader(rect);
    canvas.drawArc(rect, math.radians(270), math.radians(360 * loadingPercent),
        false, paint1);

    // blueGrey CirclePointer
    final paint2 = Paint()..color = Colors.blueGrey;
    final x1 =
        center.dx + w / 2 * cos(math.radians(270 + 360 * loadingPercent));
    final y1 =
        center.dy + w / 2 * sin(math.radians(270 + 360 * loadingPercent));
    final center2 = Offset(x1, y1);
    canvas.drawCircle(center2, circleRadius, paint2);

    // // pointers Upper indicator circle
    // final rect2 = Rect.fromCenter(center: center2, width: 37, height: 37);
    // final paint3 = Paint()
    //   ..color = Colors.white
    //   ..strokeWidth = 2
    //   ..style = PaintingStyle.stroke
    //   ..strokeCap = StrokeCap.round
    //   ..shader = gradient1.createShader(rect2);
    // if (isProgress) {
    //   canvas.drawArc(
    //       rect2, math.radians(270), math.radians(120), false, paint3);
    // }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
