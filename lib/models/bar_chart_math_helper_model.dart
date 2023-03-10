import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/bar_chart_stock_performance_model.dart';
import 'package:flutter/material.dart';

class BarChartMathHelperModel {
  final BarChartStockPerformanceModel stockData;
  final Size size;

  BarChartMathHelperModel({required this.stockData, required this.size});

  static int get numberLines => 7;

  double get additionalHeight => stockData.maxValue / ChartDimens.xxatt;

  double get maxValue => stockData.maxValue + additionalHeight;

  double get heightPerUnit => barBottom / maxValue;

  double get barPadding => ChartDimens.xxfemto;

  double get barRealWidth => barWidth - barPadding;

  double get barWidth => size.width / stockData.data.length;

  double get barBottom => size.height / 2;
}
