import 'package:animated_charts/models/candle_helper_painter_model.dart';
import 'package:animated_charts/models/candlestick_helper_painter_model.dart';
import 'package:animated_charts/models/candlestick_horizontal_line_helper_painter_model.dart';
import 'package:animated_charts/models/candlestick_math_helper_model.dart';
import 'package:animated_charts/models/candlestick_paint_dimens_model.dart';
import 'package:animated_charts/models/candlestick_stock_performance_model.dart';
import 'package:animated_charts/models/value_text_helper_painter_model.dart';
import 'package:animated_charts/models/wick_helper_painter_model.dart';
import 'package:flutter/material.dart';

class StockCandlestickPainter extends CustomPainter {
  final CandlestickStockPerformanceModel? stockData;
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

  void _drawCandlestick(Canvas canvas, Size size) {
    var painterHelper = CandlesticksChartHelperPainterModel(size: size, stockData: stockData!);

    List<CandlestickPaintDimensModel> candlesticks = painterHelper.generateCandlesticks;

    for (CandlestickPaintDimensModel candlestick in candlesticks) {
      _paintWick(candlestick: candlestick, canvas: canvas, size: painterHelper.size, animation: animation);
      _paintCandle(candlestick: candlestick, canvas: canvas, size: painterHelper.size, animation: animation);
    }
  }

  void _drawLines(Canvas canvas, Size size) {
    var model = CandlestickHorizontalLineHelperPainterModel(size: size, animation: animation, stockData: stockData!);

    for (int index = 0; index < CandlestickMathHelperModel.numberLines; ++index) {
      canvas.drawLine(model.initPoint(index), model.endPoint(index), model.linePaint);
    }
  }

  void _drawValuesText(Canvas canvas, Size size) {
    for (int index = 0; index < CandlestickMathHelperModel.numberLines; ++index) {
      var valueTex = ValueTexHelperPainterModel(index: index, stockData: stockData, animation: animation, size: size);
      valueTex.textPainter.paint(canvas, valueTex.valuesTextOffset);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (stockData == null) return;
    _drawValuesText(canvas, size);
    _drawLines(canvas, size);
    _drawCandlestick(canvas, size);
  }

  @override
  bool shouldRepaint(oldDelegate) => true;
}
