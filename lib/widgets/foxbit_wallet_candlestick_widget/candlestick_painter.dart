import 'package:animated_charts/models/candle_helper_painter_model.dart';
import 'package:animated_charts/models/candlestick_helper_painter_model.dart';
import 'package:animated_charts/models/candlestick_paint_dimens_model.dart';
import 'package:animated_charts/models/horizontal_line_helper_painter_model.dart';
import 'package:animated_charts/models/stock_time_performance_model.dart';
import 'package:animated_charts/models/value_text_helper_painter_model.dart';
import 'package:animated_charts/models/wick_helper_painter_model.dart';
import 'package:flutter/material.dart';

class StockCandlestickPainter extends CustomPainter {
  final StockTimeFramePerformanceModel? stockData;
  final Animation<double> animation;

  StockCandlestickPainter({required this.stockData, required this.animation});

  void _paintWick({
    required CandlestickPaintDimensModel candlestick,
    required Canvas canvas,
    required Size size,
    required Animation<double> animation,
  }) {
    var wickPaint = WickHelperPainterModel(candlestick: candlestick, size: size, animation: animation);
    canvas.drawRect(wickPaint.wickRect, candlestick.candlePaint);
  }

  void _paintCandle({
    required CandlestickPaintDimensModel candlestick,
    required Canvas canvas,
    required Size size,
    required Animation<double> animation,
  }) {
    var candlePaint = CandleHelperPainterModel(candlestick: candlestick, size: size, animation: animation);
    canvas.drawRRect(candlePaint.candlestickRRect, candlestick.candlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  void paint(Canvas canvas, Size size) {
    if (stockData == null) return;
    _drawValuesText(canvas, size);
    _drawLines(canvas, size);
    _drawCandlestick(canvas, size, animation);
  }

  void _drawCandlestick(Canvas canvas, Size size, Animation<double> animation) {
    Size newSize = CandlesticksChartHelperPainterModel.getNewSize(size);
    List<CandlestickPaintDimensModel> candlesticks =
        CandlesticksChartHelperPainterModel.generateCandlesticks(newSize, stockData);

    for (CandlestickPaintDimensModel candlestick in candlesticks) {
      _paintWick(candlestick: candlestick, canvas: canvas, size: newSize, animation: animation);
      _paintCandle(candlestick: candlestick, canvas: canvas, size: newSize, animation: animation);
    }
  }

  void _drawLines(Canvas canvas, Size size) {
    for (int index = 0; index < CandlesticksChartHelperPainterModel.numberLines; ++index) {
      var lineModel = HorizontalLineHelperPainterModel(index: index, size: size);
      canvas.drawLine(lineModel.initialLinePont, lineModel.endLinePont, lineModel.linePaint);
    }
  }

  void _drawValuesText(Canvas canvas, Size size) {
    for (int index = 0; index < CandlesticksChartHelperPainterModel.numberLines; ++index) {
      var valueTexModel = ValueTexHelperPainterModel(index: index, high: stockData?.high, low: stockData?.low);
      Offset offset = valueTexModel.getValuesTextOffset(index, size);
      valueTexModel.textPainter.paint(canvas, offset);
    }
  }
}
