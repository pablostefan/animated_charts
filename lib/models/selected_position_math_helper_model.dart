import 'package:animated_charts/models/line_chart_math_helper_model.dart';
import 'package:animated_charts/models/line_chart_stock_performance_model.dart';
import 'package:flutter/material.dart';

class SelectedPositionMathHelperModel {
  final LineChartStockPerformanceModel stockData;
  final Size size;
  final double? cursorPosition;
  late final LineChartMathHelperModel _mathHelper;

  SelectedPositionMathHelperModel({
    required this.stockData,
    required this.size,
    required this.cursorPosition,
  }) {
    _mathHelper = LineChartMathHelperModel(stockData: stockData, size: size);
  }

  int get _selectedIndex {
    if (cursorPosition == null) return stockData.data.length - 1;
    return cursorPosition! ~/ _mathHelper.widthPerUnit;
  }

  double get axisX => _mathHelper.widthPerUnit * _selectedIndex;

  double get axisY {
    double lineChartDataValue = stockData.data[_selectedIndex].value;

    return size.height - (lineChartDataValue - _mathHelper.minValue) * _mathHelper.heightPerUnit;
  }
}
