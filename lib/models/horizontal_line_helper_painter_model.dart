import 'package:animated_charts/helpers/chart_colors.dart';
import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/candlestick_helper_painter_model.dart';
import 'package:flutter/material.dart';

class HorizontalLineHelperPainterModel {
  final Size size;
  final Animation<double> animation;

  HorizontalLineHelperPainterModel({required this.size, required this.animation});

  double get _linesDifferencePadding => ChartDimens.xxxmicro;

  double _getLinesWidth(Size size) {
    return size.width - CandlesticksChartHelperPainterModel.leftPadding + _linesDifferencePadding;
  }

  double _getAxisY(int index) => index * CandlesticksChartHelperPainterModel.heightDistance;

  Offset initPoint(int index) {
    double axisY = _getAxisY(index);
    double axisX = _getLinesWidth(size) - _getLinesWidth(size) * animation.value;
    return Offset(axisX, axisY);
  }

  Offset endPoint(int index) => Offset(_getLinesWidth(size), _getAxisY(index));

  Paint get linePaint => Paint()
    ..color = ChartColors.darkBorder
    ..strokeWidth = ChartDimens.xatto;
}
