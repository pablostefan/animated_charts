import 'package:animated_charts/models/percentage_helper_painter_model.dart';
import 'package:animated_charts/models/pie_chart_helper_painter_model.dart';
import 'package:animated_charts/models/pie_chart_model.dart';
import 'package:animated_charts/models/pie_chart_stock_performance_model.dart';
import 'package:flutter/cupertino.dart';

class PieChartPainter extends CustomPainter {
  final PieChartStockPerformanceModel? stockData;
  final Animation<double> animation;

  PieChartPainter({required this.stockData, required this.animation});

  void _drawPieChart(Canvas canvas, Size size) {
    var helper = PieChartHelperPainterModel(size: size, stockData: stockData!, animation: animation);
    for (PieChartModel pieChart in stockData!.data) {
      canvas.drawArc(
        helper.getRect(pieChart),
        helper.getAnimatedStartAngle(pieChart),
        helper.getAnimatedSweepAngle(pieChart),
        false,
        pieChart.paint,
      );
    }
  }

  void _drawPercentage(Canvas canvas, Size size) {
    var helper = PercentageHelperPainterModel(size: size, stockData: stockData!, animation: animation);
    helper.percentageTextPainter.paint(canvas, helper.percentageTextOffset);
    helper.nameTextPainter.paint(canvas, helper.nameTextOffset);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (stockData == null) return;
    if (stockData!.data.isEmpty) return;
    _drawPieChart(canvas, size);
    _drawPercentage(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
