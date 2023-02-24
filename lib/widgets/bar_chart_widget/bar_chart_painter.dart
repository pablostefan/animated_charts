import 'package:animated_charts/models/bar_chart_helper_painter_model.dart';
import 'package:animated_charts/models/bar_chart_math_helper_model.dart';
import 'package:animated_charts/models/bar_chart_stock_performance_model.dart';
import 'package:animated_charts/models/bar_chart_tooltip_helper_painter_model.dart';
import 'package:animated_charts/models/horizontal_line_helper_painter_model.dart';
import 'package:flutter/material.dart';

class BarChartPainter extends CustomPainter {
  final BarChartStockPerformanceModel? stockData;
  final Animation<double> animation;
  final bool showTooltip;
  final Offset? cursorPosition;

  BarChartPainter({required this.stockData, required this.animation, required this.showTooltip, this.cursorPosition});

  void _drawBarChart(Canvas canvas, Size size) {
    var helper = BarChartHelperPainterModel(size: size, stockData: stockData!, animation: animation);
    for (int index = 0; index < stockData!.data.length; index++) {
      canvas.drawRRect(helper.getBarRRect(index), helper.getBarPaint(index));
    }
  }

  void _drawHorizontalLines(Canvas canvas, Size size) {
    var helper = HorizontalLineHelperPainterModel(
      size: size,
      animation: animation,
      numberLines: BarChartMathHelperModel.numberLines,
      color: Colors.grey,
    );

    for (int index = 0; index < BarChartMathHelperModel.numberLines; index++) {
      canvas.drawLine(helper.initPoint(index), helper.endPoint(index), helper.linePaint);
    }
  }

  void _drawTooltip(Canvas canvas, Size size) {
    var tooltip = BarChartTooltipHelperPainterModel(
      size: size,
      cursorPosition: cursorPosition,
      stockData: stockData!,
      animation: animation,
    );
    if (showTooltip && tooltip.showTooltip) {
      canvas.drawRRect(tooltip.tooltipRRect, tooltip.rectPaint);
      tooltip.textPainter.paint(canvas, tooltip.tooltipTextOffset);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (stockData == null) return;
    _drawBarChart(canvas, size);
    _drawHorizontalLines(canvas, size);
    _drawTooltip(canvas, size);
  }

  @override
  bool shouldRepaint(oldDelegate) => true;
}
