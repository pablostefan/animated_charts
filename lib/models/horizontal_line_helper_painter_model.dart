import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/line_chart_math_helper_model.dart';
import 'package:flutter/material.dart';

class HorizontalLineHelperPainterModel {
  final Size size;
  final Animation<double> animation;
  final int numberLines;
  final Color color;

  HorizontalLineHelperPainterModel({
    required this.size,
    required this.animation,
    this.numberLines = LineChartMathHelperModel.numberLines,
    this.color = Colors.blue,
  });

  double get _heightDistance => size.height / (numberLines - 1);

  double _getAxisY(int index) => index * _heightDistance;

  Offset initPoint(int index) {
    double axisY = _getAxisY(index);
    double axisX = 0;
    return Offset(axisX, axisY);
  }

  Offset endPoint(int index) => Offset(size.width, _getAxisY(index));

  Paint get linePaint => Paint()
    ..color = color.withOpacity(animation.value * 0.4)
    ..strokeWidth = ChartDimens.xatto;
}
