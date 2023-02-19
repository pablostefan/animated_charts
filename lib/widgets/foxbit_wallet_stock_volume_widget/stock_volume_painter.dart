import 'package:animated_charts/models/bar_helper_painter_model.dart';
import 'package:animated_charts/models/bar_model.dart';
import 'package:animated_charts/models/stock_time_performance_model.dart';
import 'package:flutter/material.dart';

class StockVolumePainter extends CustomPainter {
  final StockTimeFramePerformanceModel? stockData;
  final Animation<double> animation;

  StockVolumePainter({required this.stockData, required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    if (stockData == null) return;
    BarHelperPainterModel barHelper = BarHelperPainterModel(stockData: stockData, animation: animation, size: size);
    List<BarModel> bars = barHelper.generateBars;

    for (BarModel bar in bars) {
      double barLeft = BarHelperPainterModel.getBarLeft(bar);
      double barTop = BarHelperPainterModel.getBarTop(bar, size);

      canvas.drawRect(Rect.fromLTWH(barLeft, barTop, bar.width, bar.height), bar.paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
