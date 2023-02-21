import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/line_chart_helper_painter_model.dart';
import 'package:flutter/material.dart';

class LineChartHorizontalLineHelperPainterModel {
  final Size size;
  final Animation<double> animation;

  LineChartHorizontalLineHelperPainterModel({required this.size, required this.animation});

  double _getAxisY(int index) => index * LineChartHelperPainterModel.heightDistance;

  Offset initPoint(int index) {
    double axisY = _getAxisY(index);
    double axisX = 0;
    return Offset(axisX, axisY);
  }

  Offset endPoint(int index) => Offset(size.width, _getAxisY(index));

  Paint get linePaint => Paint()
    ..color = Colors.blue.withOpacity(animation.value * 0.4)
    ..strokeWidth = ChartDimens.xatto;
}
