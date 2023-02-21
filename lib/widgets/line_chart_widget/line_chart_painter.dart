import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/cursor_helper_painter_model.dart';
import 'package:animated_charts/models/dotted_line_helper_painter_model.dart';
import 'package:animated_charts/models/line_chart_helper_painter_model.dart';
import 'package:animated_charts/models/line_chart_horizontal_line_helper_painter_model.dart';
import 'package:animated_charts/models/line_chart_stock_performance_model.dart';
import 'package:dash_painter/dash_painter.dart';
import 'package:flutter/material.dart';

class LineChartPainter extends CustomPainter {
  final LineChartStockPerformanceModel? stockData;
  final Animation<double> animation;
  final double? cursorPosition;

  LineChartPainter({required this.stockData, required this.animation, required this.cursorPosition});

  void _drawCurveLines(Canvas canvas, LineChartHelperPainterModel lineChartHelper) {
    canvas.drawPath(lineChartHelper.animatedLinePath, lineChartHelper.linePaint);
  }

  void _drawGradient(Canvas canvas, LineChartHelperPainterModel lineChartHelper) {
    final Path gradientPath = lineChartHelper.gradientPath;
    canvas.drawPath(gradientPath, lineChartHelper.gradientPaint);
  }

  void _drawHorizontalLines(Canvas canvas, Size size) {
    var lineModel = LineChartHorizontalLineHelperPainterModel(size: size, animation: animation);

    for (int index = 0; index < LineChartHelperPainterModel.numberLines; ++index) {
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
    var verticalLine = CursorHelperPainterModel(
      size: size,
      cursorPosition: cursorPosition,
      animation: animation,
      stockData: stockData!,
    );

    canvas.drawPath(verticalLine.bigCirclePath, verticalLine.bigCirclePainter);
    canvas.drawPath(verticalLine.smallCirclePath, verticalLine.smallCirclePainter);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (stockData == null) return;
    var lineChartHelper = LineChartHelperPainterModel(stockData: stockData!, size: size, animation: animation);

    _drawCurveLines(canvas, lineChartHelper);
    _drawGradient(canvas, lineChartHelper);
    _drawHorizontalLines(canvas, size);
    _drawDashedVerticalLines(canvas, size);
    _drawCursor(canvas, size);
  }

  @override
  bool shouldRepaint(_) => true;
}
