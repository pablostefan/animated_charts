import 'dart:ui';

import 'package:animated_charts/models/line_chart_data_model.dart';
import 'package:animated_charts/models/line_chart_stock_performance_model.dart';
import 'package:animated_charts/widgets/line_chart_widget/line_chart_widget.dart';
import 'package:flutter/material.dart';

class LineChartHelperPainterModel {
  final LineChartStockPerformanceModel stockData;
  final Size size;
  final Animation<double> animation;

  LineChartHelperPainterModel({required this.stockData, required this.size, required this.animation});

  static const int numberLines = 8;

  static double get heightDistance => LineChartWidget.height / (numberLines - 1);

  double get _heightPerUnit => size.height / (stockData.maxValue - stockData.minValue);

  double get _widthPerUnit => size.width / (stockData.data.length - 1);

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

  double _getAxisX(int index) => index * _widthPerUnit;

  double _getAxisY(int index, double animationValue) {
    double lineChartDataValue = stockData.data[index].value;

    return size.height - (lineChartDataValue - stockData.minValue) * _heightPerUnit * animationValue;
  }

  Offset _getOffsetFromValue(LineChartDataModel model, {double animationValue = 1}) {
    int index = stockData.data.indexOf(model);
    double axisY = _getAxisY(index, animationValue);
    double axisX = _getAxisX(index);

    return Offset(axisX, axisY);
  }

  double _remap(double value, double start1, double stop1, double start2, double stop2) {
    final outgoing = start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1));

    return outgoing;
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
    Path path = Path();
    List<Offset> points = [
      Offset(0, size.height),
      ...stockData.data.map((e) => _getOffsetFromValue(e, animationValue: animation.value)).toList(),
      Offset(_getAxisX(stockData.data.length - 1), size.height),
    ];

    path.addPolygon(points, true);

    return path;
  }
}
