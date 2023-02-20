import 'dart:ui';

import 'package:animated_charts/models/line_chart_stock_performance_model.dart';
import 'package:flutter/material.dart';

class LineChartHelperPainterModel {
  final LineChartStockPerformanceModel stockData;
  final Size size;
  final Animation<double> animation;

  LineChartHelperPainterModel({required this.stockData, required this.size, required this.animation});

  double get _heightPerUnit => size.height / (stockData.maxValue - stockData.minValue);

  double get _widthPerUnit => size.width / (stockData.data.length - 1);

  int get _getLength => (stockData.data.length * animation.value).toInt();

  Paint get linePaint => Paint()
    ..color = Colors.black
    ..strokeWidth = 2
    ..style = PaintingStyle.stroke;

  Path get contourPath => _calcPartialPath;

  Path get _contourPath {
    Path path = Path();
    for (int index = 0; index < _getLength; index++) {
      Offset offset = _getOffsetFromValue(index);
      index == 0 ? path.moveTo(offset.dx, offset.dy) : path.lineTo(offset.dx, offset.dy);
    }
    return path;
  }

  double _getAxisX(int index) => index * _widthPerUnit;

  double _getAxisY(int index) {
    double lineChartDataValue = stockData.data[index].value;

    if (lineChartDataValue == stockData.maxValue) return 0;
    if (lineChartDataValue == stockData.minValue) return size.height;

    return size.height - (lineChartDataValue - stockData.minValue) * _heightPerUnit;
  }

  Offset _getOffsetFromValue(int index) {
    double axisY = _getAxisY(index);
    double axisX = _getAxisX(index);

    return Offset(axisX, axisY);
  }

  double _remap(double value, double start1, double stop1, double start2, double stop2) {
    final outgoing = start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1));

    return outgoing;
  }

  Path get _calcPartialPath {
    if (_contourPath.computeMetrics().isEmpty) return Path();

    Path path = _contourPath;
    List<PathMetric> metrics = path.computeMetrics().toList();
    PathMetric metric = metrics.first;
    double drawLimit = _remap(animation.value, 0, 1, 0, metric.length);
    Path partialPath = Path();
    double currentContour = 0.0;

    while (currentContour < drawLimit) {
      final contour = metric.getTangentForOffset(currentContour)!;
      if (currentContour == 0.0) {
        partialPath.moveTo(contour.position.dx, contour.position.dy);
      } else {
        partialPath.lineTo(contour.position.dx, contour.position.dy);
      }
      currentContour += 1;
    }

    return partialPath;
  }
}
