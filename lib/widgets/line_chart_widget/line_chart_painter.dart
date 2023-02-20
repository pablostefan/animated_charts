import 'package:animated_charts/models/line_chart_helper_painter_model.dart';
import 'package:animated_charts/models/line_chart_stock_performance_model.dart';
import 'package:flutter/cupertino.dart';

class LineChartPainter extends CustomPainter {
  final LineChartStockPerformanceModel? stockData;
  final Animation<double> animation;

  LineChartPainter({required this.stockData, required this.animation});

  void _drawLines(Canvas canvas, LineChartHelperPainterModel lineChartHelper) {
    final Path linePath = lineChartHelper.contourPath;
    canvas.drawPath(linePath, lineChartHelper.linePaint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (stockData == null) return;
    var lineChartHelper = LineChartHelperPainterModel(stockData: stockData!, size: size, animation: animation);
    _drawLines(canvas, lineChartHelper);
  }

  @override
  bool shouldRepaint(_) => true;
}
