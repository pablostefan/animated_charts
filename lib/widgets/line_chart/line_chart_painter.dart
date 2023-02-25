import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/cursor_helper_painter_model.dart';
import 'package:animated_charts/models/dotted_line_helper_painter_model.dart';
import 'package:animated_charts/models/horizontal_line_helper_painter_model.dart';
import 'package:animated_charts/models/line_chart_helper_painter_model.dart';
import 'package:animated_charts/models/line_chart_math_helper_model.dart';
import 'package:animated_charts/models/line_chart_stock_performance_model.dart';
import 'package:animated_charts/models/line_chart_tooltip_helper_painter_model.dart';
import 'package:dash_painter/dash_painter.dart';
import 'package:flutter/material.dart';

class LineChartPainter extends CustomPainter {
  final LineChartStockPerformanceModel? stockData;
  final Animation<double> animation;
  final double? cursorPosition;
  final bool showTooltip;

  LineChartPainter({
    required this.stockData,
    required this.animation,
    required this.cursorPosition,
    required this.showTooltip,
  });

  void _drawChartCurveLines(Canvas canvas, LineChartHelperPainterModel lineChartHelper) {
    canvas.drawPath(lineChartHelper.animatedLineChartPath, lineChartHelper.linePaint);
  }

  void _drawGradient(Canvas canvas, LineChartHelperPainterModel lineChartHelper) {
    canvas.drawPath(lineChartHelper.gradientPath, lineChartHelper.gradientPaint);
  }

  void _drawHorizontalLines(Canvas canvas, Size size) {
    var lineModel = HorizontalLineHelperPainterModel(size: size, animation: animation);

    for (int index = 0; index < LineChartMathHelperModel.numberLines; ++index) {
      canvas.drawLine(lineModel.initPoint(index), lineModel.endPoint(index), lineModel.linePaint);
    }
  }

  void _drawDashedVerticalLines(Canvas canvas, Size size) {
    var verticalLine = DottedLineHelperPainterModel(
      size: size,
      cursorPosition: cursorPosition,
      animation: animation,
      stockData: stockData!,
    );

    const DashPainter(
      span: ChartDimens.femto,
      step: ChartDimens.nano,
    ).paint(canvas, verticalLine.linePath, verticalLine.linePaint);
  }

  void _drawCursor(Canvas canvas, Size size) {
    var verticalLine = CursorHelperPainterModel(size: size, cursorPosition: cursorPosition, stockData: stockData!);

    canvas.drawPath(verticalLine.bigCirclePath, verticalLine.bigCirclePainter);
    canvas.drawPath(verticalLine.smallCirclePath, verticalLine.smallCirclePainter);
  }

  void _drawTooltip(Canvas canvas, Size size) {
    if (showTooltip) {
      var tooltip = LineChartTooltipHelperPainterModel(
        size: size,
        cursorPosition: cursorPosition,
        stockData: stockData!,
        animation: animation,
      );

      canvas.drawRRect(tooltip.tooltipRRect, tooltip.rectPaint);
      tooltip.textPainter.paint(canvas, tooltip.tooltipTextOffset);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (stockData == null) return;
    if (stockData!.data.isEmpty) return;

    var lineChartHelper = LineChartHelperPainterModel(stockData: stockData!, size: size, animation: animation);

    _drawChartCurveLines(canvas, lineChartHelper);
    _drawHorizontalLines(canvas, size);
    _drawGradient(canvas, lineChartHelper);
    _drawDashedVerticalLines(canvas, size);
    _drawTooltip(canvas, size);
    _drawCursor(canvas, size);
  }

  @override
  bool shouldRepaint(oldDelegate) => true;
}
