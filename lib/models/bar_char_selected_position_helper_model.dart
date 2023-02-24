import 'package:animated_charts/models/bar_chart_math_helper_model.dart';
import 'package:animated_charts/models/bar_chart_model.dart';
import 'package:animated_charts/models/bar_chart_stock_performance_model.dart';
import 'package:flutter/material.dart';

class BarChartSelectedPositionHelperModel {
  final BarChartStockPerformanceModel stockData;
  final Size size;
  final double? cursorPosition;
  late final BarChartMathHelperModel _mathHelper;

  BarChartSelectedPositionHelperModel({
    required this.stockData,
    required this.size,
    required this.cursorPosition,
  }) {
    _mathHelper = BarChartMathHelperModel(stockData: stockData, size: size);
  }

  int get _selectedIndex {
    if (cursorPosition == null) return stockData.data.length - 1;
    return cursorPosition! ~/ _mathHelper.barWidth;
  }

  double get axisX => _mathHelper.barRealWidth * _selectedIndex;

  double get axisY {
    double barChartValue = stockData.data[_selectedIndex].value;
    double barHeight = (barChartValue.abs() - _mathHelper.minValue) * _mathHelper.heightPerUnit;

    if (barChartValue > 0) return (_mathHelper.barBottom - barHeight) / 2;
    if (barChartValue < 0) return (_mathHelper.barBottom + barHeight) / 2;

    return _mathHelper.barBottom;
  }

  BarChartModel get selectedData => stockData.data[_selectedIndex];
}
