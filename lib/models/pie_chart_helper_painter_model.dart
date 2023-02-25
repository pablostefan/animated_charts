import 'package:animated_charts/models/pie_chart_math_helper_model.dart';
import 'package:animated_charts/models/pie_chart_model.dart';
import 'package:animated_charts/models/pie_chart_stock_performance_model.dart';
import 'package:flutter/material.dart';

class PieChartHelperPainterModel {
  final PieChartStockPerformanceModel stockData;
  final Size size;
  final Animation<double> animation;
  late final PieChartMathHelperModel _mathHelper;

  PieChartHelperPainterModel({required this.stockData, required this.size, required this.animation}) {
    _mathHelper = PieChartMathHelperModel(stockData: stockData, size: size);
  }

  double getAnimatedSweepAngle(PieChartModel pieChart) => pieChart.sweepAngle * animation.value;

  double getAnimatedStartAngle(PieChartModel pieChart) => pieChart.startAngle * animation.value;

  Rect getRect(PieChartModel pieChart) {
    return Rect.fromCircle(center: _mathHelper.center, radius: _mathHelper.getRadius(pieChart));
  }
}
