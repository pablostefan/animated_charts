import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/bar_chart_math_helper_model.dart';
import 'package:animated_charts/models/bar_chart_stock_performance_model.dart';
import 'package:flutter/material.dart';

class BarChartHelperPainterModel {
  final BarChartStockPerformanceModel stockData;
  final Animation<double> animation;
  final Size size;
  late final BarChartMathHelperModel _mathHelper;

  BarChartHelperPainterModel({required this.stockData, required this.animation, required this.size}) {
    _mathHelper = BarChartMathHelperModel(stockData: stockData, size: size);
  }

  double _getBarLeft(int index) => index * _mathHelper.barWidth;

  double _getBarRight(int index) => index * _mathHelper.barWidth + _mathHelper.barRealWidth;

  double _getBarTop(int index) {
    double barChartValue = stockData.data[index].value;
    double barHeight = barChartValue.abs() * _mathHelper.heightPerUnit * animation.value;

    if (barChartValue > 0) return _mathHelper.barBottom - barHeight;
    if (barChartValue < 0) return _mathHelper.barBottom + barHeight;

    return _mathHelper.barBottom;
  }

  Paint getBarPaint(int index) {
    return Paint()
      ..color = stockData.data[index].color
      ..style = PaintingStyle.fill;
  }

  Radius get _barRadius => const Radius.circular(ChartDimens.femto);

  RRect _getPositiveBarRRect(int index) {
    double barLeft = _getBarLeft(index);
    double barRight = _getBarRight(index);
    double barTop = _getBarTop(index);
    double barBottom = _mathHelper.barBottom;

    return RRect.fromLTRBAndCorners(barLeft, barTop, barRight, barBottom, topLeft: _barRadius, topRight: _barRadius);
  }

  RRect _getNegativeBarRRect(int index) {
    double barLeft = _getBarLeft(index);
    double barRight = _getBarRight(index);
    double barTop = _mathHelper.barBottom;
    double barBottom = _getBarTop(index);

    return RRect.fromLTRBAndCorners(
      barLeft,
      barTop,
      barRight,
      barBottom,
      bottomLeft: _barRadius,
      bottomRight: _barRadius,
    );
  }

  RRect _getZeroBarRRect(int index) {
    double barLeft = _getBarLeft(index);
    double barRight = _getBarRight(index);
    double barTop = _mathHelper.barBottom - 1;
    double barBottom = _mathHelper.barBottom + 1;

    return RRect.fromLTRBR(barLeft, barTop, barRight, barBottom, _barRadius);
  }

  RRect getBarRRect(int index) {
    if (stockData.data[index].value > 0) return _getPositiveBarRRect(index);
    if (stockData.data[index].value < 0) return _getNegativeBarRRect(index);
    return _getZeroBarRRect(index);
  }
}
