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

  double _remap(double value, double start1, double stop1, double start2, double stop2) {
    return start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1));
  }

  Path get animatedLinePath {
    if (_linePath.computeMetrics().isEmpty) return Path();

    Path path = _linePath;
    List<PathMetric> metrics = path.computeMetrics().toList();
    PathMetric metric = metrics.first;
    double drawLimit = _remap(animation.value, 0, 1, 0, metric.length);
    Path partialPath = Path();
    double currentContour = 0.0;

    while (currentContour < drawLimit) {
      final contour = metric.getTangentForOffset(currentContour)!;

      currentContour == 0.0
          ? partialPath.moveTo(contour.position.dx, contour.position.dy)
          : partialPath.lineTo(contour.position.dx, contour.position.dy);

      currentContour += 1;
    }

    return partialPath;
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
