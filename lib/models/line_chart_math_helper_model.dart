import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/line_chart_stock_performance_model.dart';
import 'package:flutter/material.dart';

class LineChartMathHelperModel {
  final LineChartStockPerformanceModel stockData;
  final Size size;

  LineChartMathHelperModel({required this.stockData, required this.size});

  static const int numberLines = 8;

  double get heightDistance => size.height / (numberLines - 1);

  double get additionalHeight => (stockData.maxValue - stockData.minValue) / ChartDimens.pico;

  double get maxValue => stockData.maxValue + additionalHeight;

  double get minValue => stockData.minValue - additionalHeight;

  double get heightPerUnit => size.height / (maxValue - minValue);

  double get widthPerUnit => size.width / (stockData.data.length - 1);
}
