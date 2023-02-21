import 'package:animated_charts/models/line_chart_helper_painter_model.dart';
import 'package:animated_charts/models/line_chart_horizontal_line_helper_painter_model.dart';
import 'package:animated_charts/models/line_chart_stock_performance_model.dart';
import 'package:flutter/material.dart';

class LineChartPainter extends CustomPainter {
  final LineChartStockPerformanceModel? stockData;
  final Animation<double> animation;

  LineChartPainter({required this.stockData, required this.animation});

  void _drawCurveLines(Canvas canvas, LineChartHelperPainterModel lineChartHelper) {
    canvas.drawPath(lineChartHelper.animatedLinePath, lineChartHelper.linePaint);
  }

  void _drawGradient(Canvas canvas, LineChartHelperPainterModel lineChartHelper) {
    final Path gradientPath = lineChartHelper.gradientPath;
    canvas.drawPath(gradientPath, lineChartHelper.gradientPaint);
  }

  void _drawLines(Canvas canvas, Size size) {
    var lineModel = LineChartHorizontalLineHelperPainterModel(size: size, animation: animation);

    for (int index = 0; index < LineChartHelperPainterModel.numberLines; ++index) {
      canvas.drawLine(lineModel.initPoint(index), lineModel.endPoint(index), lineModel.linePaint);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (stockData == null) return;
    var lineChartHelper = LineChartHelperPainterModel(stockData: stockData!, size: size, animation: animation);

    _drawCurveLines(canvas, lineChartHelper);
    _drawGradient(canvas, lineChartHelper);
    _drawLines(canvas, size);
  }

  @override
  bool shouldRepaint(_) => true;
}
