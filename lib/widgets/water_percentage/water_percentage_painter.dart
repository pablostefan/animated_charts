import 'package:animated_charts/models/water_percentage_painter_helper.dart';
import 'package:flutter/material.dart';

class WaterPercentagePainter extends CustomPainter {
  final double firstAnimationValue;
  final double secondAnimationValue;
  final double percentageAnimation;
  final double borderAnimation;
  final double percentage;

  WaterPercentagePainter({
    required this.firstAnimationValue,
    required this.secondAnimationValue,
    required this.percentageAnimation,
    required this.borderAnimation,
    required this.percentage,
  });

  void _drawWater(Canvas canvas, Size size, WaterPercentagePainterHelper helper) {
    canvas.drawPath(helper.animatedWaterPath, helper.gradientPaint);
  }

  void _drawBorder(Canvas canvas, Size size, WaterPercentagePainterHelper helper) {
    canvas.drawPath(helper.animatedBorderPath, helper.borderPaint);
  }

  void _drawPercentage(Canvas canvas, Size size, WaterPercentagePainterHelper helper) {
    helper.percentageTextPainter.paint(canvas, helper.percentageTextOffset);
  }

  @override
  void paint(Canvas canvas, Size size) {
    var helper = WaterPercentagePainterHelper(
      size: size,
      borderAnimation: borderAnimation,
      percentageAnimation: percentageAnimation,
      firstAnimationValue: firstAnimationValue,
      secondAnimationValue: secondAnimationValue,
    );

    _drawWater(canvas, size, helper);
    _drawBorder(canvas, size, helper);
    _drawPercentage(canvas, size, helper);
  }

  @override
  bool shouldRepaint(oldDelegate) => true;
}
