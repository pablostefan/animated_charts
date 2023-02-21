import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/line_chart_stock_performance_model.dart';
import 'package:flutter/material.dart';

class CursorHelperPainterModel {
  final Size size;
  final double? cursorPosition;
  final LineChartStockPerformanceModel stockData;

  CursorHelperPainterModel({
    required this.size,
    required this.cursorPosition,
    required this.stockData,
  });

  Paint get bigCirclePainter => Paint()
    ..style = PaintingStyle.fill
    ..color = Colors.yellowAccent;

  Paint get shadowPainter => Paint()
    ..style = PaintingStyle.fill
    ..color = Colors.yellowAccent.withOpacity(0.5)
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, ChartDimens.pico);

  Paint get smallCirclePainter => Paint()
    ..style = PaintingStyle.fill
    ..color = Colors.black;

  double get _widthPerUnit => size.width / (stockData.data.length - 1);

  double get _heightPerUnit => size.height / (stockData.maxValue - stockData.minValue);

  int get _selectedIndex {
    if (cursorPosition == null) return stockData.data.length - 1;
    return cursorPosition! ~/ _widthPerUnit;
  }

  double get _axisX => _widthPerUnit * _selectedIndex;

  double get _axisY {
    double lineChartDataValue = stockData.data[_selectedIndex].value;

    return size.height - (lineChartDataValue - stockData.minValue) * _heightPerUnit;
  }

  Path get smallCirclePath {
    final path = Path()..addOval(Rect.fromCircle(center: Offset(_axisX, _axisY), radius: ChartDimens.xfemto));

    return path;
  }

  Path get bigCirclePath {
    final path = Path()..addOval(Rect.fromCircle(center: Offset(_axisX, _axisY), radius: ChartDimens.pico));

    return path;
  }
}
