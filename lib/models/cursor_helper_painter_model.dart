import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/line_chart_selected_position_helper_model.dart';
import 'package:animated_charts/models/line_chart_stock_performance_model.dart';
import 'package:flutter/material.dart';

class CursorHelperPainterModel {
  final Size size;
  final double? cursorPosition;
  final LineChartStockPerformanceModel stockData;
  late final LineChartSelectedPositionHelperModel _positionHelper;

  CursorHelperPainterModel({
    required this.size,
    required this.cursorPosition,
    required this.stockData,
  }) {
    _positionHelper =
        LineChartSelectedPositionHelperModel(stockData: stockData, size: size, cursorPosition: cursorPosition);
  }

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

  double get _axisX => _positionHelper.axisX;

  double get _axisY => _positionHelper.axisY;

  Path get smallCirclePath {
    final path = Path()..addOval(Rect.fromCircle(center: Offset(_axisX, _axisY), radius: ChartDimens.xfemto));

    return path;
  }

  Path get bigCirclePath {
    final path = Path()..addOval(Rect.fromCircle(center: Offset(_axisX, _axisY), radius: ChartDimens.pico));

    return path;
  }
}
