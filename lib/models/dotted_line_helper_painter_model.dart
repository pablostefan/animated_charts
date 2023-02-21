import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/line_chart_stock_performance_model.dart';
import 'package:flutter/material.dart';

class DottedLineHelperPainterModel {
  final Size size;
  final double? cursorPosition;
  final LineChartStockPerformanceModel stockData;
  final Animation<double> animation;

  DottedLineHelperPainterModel({
    required this.size,
    required this.cursorPosition,
    required this.stockData,
    required this.animation,
  });

  double get _widthPerUnit => size.width / (stockData.data.length - 1);

  int get _selectedIndex {
    if (cursorPosition == null) return stockData.data.length - 1;
    return cursorPosition! ~/ _widthPerUnit;
  }

  double get _axisX => _widthPerUnit * _selectedIndex;

  double get _axisY => size.height * animation.value;

  Paint get linePaint => Paint()
    ..color = Colors.black.withOpacity(ChartDimens.xxhetter)
    ..strokeCap = StrokeCap.round
    ..strokeWidth = ChartDimens.xatto
    ..style = PaintingStyle.stroke;

  Path get linePath {
    final path = Path()
      ..moveTo(_axisX, 0)
      ..lineTo(_axisX, _axisY);

    return path;
  }
}
