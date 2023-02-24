import 'package:animated_charts/models/bar_chart_math_helper_model.dart';
import 'package:animated_charts/models/bar_chart_model.dart';
import 'package:animated_charts/models/bar_chart_stock_performance_model.dart';
import 'package:flutter/material.dart';

class BarChartSelectedPositionHelperModel {
  final BarChartStockPerformanceModel stockData;
  final Size size;
  final Offset? cursorPosition;
  late final BarChartMathHelperModel _mathHelper;

  BarChartSelectedPositionHelperModel({
    required this.stockData,
    required this.size,
    required this.cursorPosition,
  }) {
    _mathHelper = BarChartMathHelperModel(stockData: stockData, size: size);
  }

  bool get positiveValue => _selectedDataValue >= 0;

  double get _selectedDataValue => stockData.data[_selectedIndex].value;

  int get _selectedIndex {
    if (cursorPosition == null) return stockData.data.length - 1;
    return cursorPosition!.dx ~/ _mathHelper.barWidth;
  }

  double get centerX => _mathHelper.barWidth * _selectedIndex + _mathHelper.barRealWidth / 2;

  bool get cursorInsideChart {
    if (cursorPosition == null) {
      return false;
    } else if (positiveValue) {
      return cursorPosition!.dy <= _mathHelper.barBottom && cursorPosition!.dy >= _barTop;
    } else {
      return cursorPosition!.dy >= _mathHelper.barBottom && cursorPosition!.dy <= _barTop;
    }
  }

  double get _barHeight => _selectedDataValue.abs() * _mathHelper.heightPerUnit;

  double get _barTop {
    if (positiveValue) {
      return _mathHelper.barBottom - _barHeight;
    } else {
      return _mathHelper.barBottom + _barHeight;
    }
  }

  BarChartModel get selectedData => stockData.data[_selectedIndex];
}
