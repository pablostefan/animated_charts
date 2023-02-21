import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/line_chart_stock_performance_model.dart';
import 'package:animated_charts/models/selected_position_math_helper_model.dart';
import 'package:flutter/material.dart';

class DottedLineHelperPainterModel {
  final Size size;
  final double? cursorPosition;
  final LineChartStockPerformanceModel stockData;
  final Animation<double> animation;
  late final SelectedPositionMathHelperModel _positionHelper;

  DottedLineHelperPainterModel({
    required this.size,
    required this.cursorPosition,
    required this.stockData,
    required this.animation,
  }) {
    _positionHelper = SelectedPositionMathHelperModel(stockData: stockData, size: size, cursorPosition: cursorPosition);
  }

  Paint get linePaint => Paint()
    ..color = Colors.black.withOpacity(ChartDimens.xxhetter)
    ..strokeCap = StrokeCap.round
    ..strokeWidth = ChartDimens.xatto
    ..style = PaintingStyle.stroke;

  Path get linePath {
    final path = Path()
      ..moveTo(_positionHelper.axisX, 0)
      ..lineTo(_positionHelper.axisX, _positionHelper.axisY);

    return path;
  }
}