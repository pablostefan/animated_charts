import 'dart:math';

import 'package:animated_charts/models/pie_chart_math_helper_model.dart';
import 'package:flutter/material.dart';

class PieChartModel {
  final String name;
  final double percentage;
  final Color color;
  bool isSelected = false;
  double _startAngle = 0;
  double _sweepAngle = 0;

  PieChartModel({required this.name, required this.percentage, required this.color});

  Paint get paint => isSelected ? _selectedPaint : _unselectedPaint;

  double get strokeWidth {
    return isSelected ? PieChartMathHelperModel.selectedStrokeWidth : PieChartMathHelperModel.strokeWidth;
  }

  Paint get _selectedPaint => Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = strokeWidth
    ..color = color
    ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 30);

  Paint get _unselectedPaint => Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = strokeWidth
    ..color = color;

  double get startAngle => isSelected ? _startAngleWithAdditionalAngle : _startAngle;

  double get sweepAngle => isSelected ? _sweepAngleWithAdditionalAngle : _sweepAngle;

  double get _additionalAngle => pi / 70;

  double get _startAngleWithAdditionalAngle => _startAngle + _additionalAngle;

  double get _sweepAngleWithAdditionalAngle => _sweepAngle - _additionalAngle * 2;

  void setStartAngle(double startAngle) => _startAngle = startAngle;

  void setSweepAngle(double sweepAngle) => _sweepAngle = sweepAngle;
}
