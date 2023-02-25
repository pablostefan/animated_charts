import 'dart:ui';

import 'package:animated_charts/models/line_chart_data_model.dart';
import 'package:animated_charts/models/line_chart_math_helper_model.dart';
import 'package:animated_charts/models/line_chart_stock_performance_model.dart';
import 'package:flutter/material.dart';

class LineChartHelperPainterModel {
  final LineChartStockPerformanceModel stockData;
  final Size size;
  final Animation<double> animation;
  late final LineChartMathHelperModel _mathHelper;

  LineChartHelperPainterModel({required this.stockData, required this.size, required this.animation}) {
    _mathHelper = LineChartMathHelperModel(stockData: stockData, size: size);
  }

  List<Color> get _gradientColors => [Colors.blue.withOpacity(0.7), Colors.blue.withOpacity(0.2)];

  Paint get gradientPaint => Paint()
    ..shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: _gradientColors,
    ).createShader(Rect.fromCenter(height: size.height, width: 0, center: Offset(size.width / 2, size.height / 2)));

  Paint get linePaint => Paint()
    ..color = Colors.blue
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;

  Path get _linePath {
    Path path = Path();

    for (LineChartDataModel element in stockData.data) {
      Offset offset = _getOffsetFromValue(element);
      bool isFirst = stockData.data.first == element;
      isFirst ? path.moveTo(offset.dx, offset.dy) : path.lineTo(offset.dx, offset.dy);
    }

    return path;
  }

  double _getAxisX(int index) => index * _mathHelper.widthPerUnit;

  double _getAxisY(int index, double animationValue) {
    double lineChartDataValue = stockData.data[index].value;

    return size.height - (lineChartDataValue - _mathHelper.minValue) * _mathHelper.heightPerUnit * animationValue;
  }

  Offset _getOffsetFromValue(LineChartDataModel model, {double animationValue = 1}) {
    int index = stockData.data.indexOf(model);
    double axisY = _getAxisY(index, animationValue);
    double axisX = _getAxisX(index);

    return Offset(axisX, axisY);
  }

  Path get animatedLineChartPath {
    if (_linePath.computeMetrics().isEmpty) return Path();

    Path path = _linePath;
    Path dashPath = Path();

    PathMetric pathMetric = path.computeMetrics().first;
    double drawLength = pathMetric.length * animation.value;
    double distance = 0;

    while (distance < drawLength) {
      Tangent tangent = pathMetric.getTangentForOffset(distance)!;
      Offset start = tangent.position - tangent.vector;
      Offset end = tangent.position;
      dashPath.moveTo(start.dx, start.dy);
      dashPath.lineTo(end.dx, end.dy);
      distance += 1;
    }

    return dashPath;
  }

  Path get gradientPath {
    Path path = Path()..moveTo(0, size.height);

    for (LineChartDataModel element in stockData.data) {
      Offset offset = _getOffsetFromValue(element, animationValue: animation.value);
      path.lineTo(offset.dx, offset.dy);
    }
    path.lineTo(size.width, size.height);
    path.close();

    return path;
  }
}
