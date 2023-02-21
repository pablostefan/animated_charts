import 'package:animated_charts/helpers/chart_colors.dart';
import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/candlestick_math_helper_model.dart';
import 'package:animated_charts/models/candlestick_stock_performance_model.dart';
import 'package:flutter/material.dart';

class CandlestickHorizontalLineHelperPainterModel {
  final Size size;
  final Animation<double> animation;
  final CandlestickStockPerformanceModel stockData;
  late final CandlestickMathHelperModel _mathHelper;

  CandlestickHorizontalLineHelperPainterModel({required this.size, required this.animation, required this.stockData}) {
    _mathHelper = CandlestickMathHelperModel(size: size, stockData: stockData);
  }

  Offset initPoint(int index) {
    double axisY = _mathHelper.getAxisY(index);
    double axisX = _mathHelper.linesWidth - _mathHelper.linesWidth * animation.value;

    return Offset(axisX, axisY);
  }

  Offset endPoint(int index) => Offset(_mathHelper.linesWidth, _mathHelper.getAxisY(index));

  Paint get linePaint => Paint()
    ..color = ChartColors.darkBorder
    ..strokeWidth = ChartDimens.xatto;
}
