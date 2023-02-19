import 'package:animated_charts/helpers/chart_colors.dart';
import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/candlestick_helper_painter_model.dart';
import 'package:flutter/material.dart';

class HorizontalLineHelperPainterModel {
  final int index;
  final Size size;

  HorizontalLineHelperPainterModel({required this.index, required this.size});

  double get _linesDifferencePadding => ChartDimens.xxxmicro;

  double _getLinesWidth(Size size) =>
      size.width - CandlesticksChartHelperPainterModel.leftPadding + _linesDifferencePadding;

  double get axisY => index * CandlesticksChartHelperPainterModel.heightDistance;

  Paint get linePaint => Paint()
    ..color = ChartColors.darkBorder
    ..strokeWidth = ChartDimens.xatto;

  Offset get initialLinePont => Offset(0, axisY);

  Offset get endLinePont => Offset(_getLinesWidth(size), axisY);
}
