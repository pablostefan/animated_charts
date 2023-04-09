import 'package:animated_charts/models/bar_helper_painter_model.dart';
import 'package:animated_charts/models/bar_model.dart';
import 'package:animated_charts/models/candlestick_stock_performance_model.dart';
import 'package:flutter/material.dart';

class StockVolumePainter extends CustomPainter {
  final CandlestickStockPerformanceModel? stockData;
  final Animation<double> animation;
  final double? cursorPosition;
  final bool showTooltip;

  StockVolumePainter({
    required this.stockData,
    required this.animation,
    required this.cursorPosition,
    required this.showTooltip,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (stockData == null) return;
    if (stockData!.data.isEmpty) return;

    BarHelperPainterModel barHelper = BarHelperPainterModel(
        stockData: stockData!,
        animation: animation,
        size: size,
        cursorPosition: cursorPosition,
        showTooltip: showTooltip);

    for (int index = 0; index < stockData!.data.length; index++) {
      BarModel barModel = barHelper.getBarModel(index);
      canvas.drawRect(barModel.barRect, barModel.barPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
