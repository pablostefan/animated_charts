import 'package:animated_charts/models/candlestick_math_helper_model.dart';
import 'package:animated_charts/models/candlestick_paint_dimens_model.dart';
import 'package:animated_charts/models/candlestick_stock_performance_model.dart';
import 'package:flutter/material.dart';

class CandleHelperPainterModel {
  final CandlestickPaintDimensModel candlestick;
  final Size size;
  final Animation<double> animation;
  final CandlestickStockPerformanceModel stockData;

  CandleHelperPainterModel({
    required this.candlestick,
    required this.size,
    required this.animation,
    required this.stockData,
  });

  double get _candleWith {
    double candleWith = (size.width / stockData.data.length) * .7;

    return candleWith > 7 ? 7 : candleWith;
  }

  double get _candleTop => size.height - candlestick.candleHighY;

  double get _candleBottom => size.height - candlestick.candleLowY;

  double get _candleCenterY => (_candleTop + _candleBottom) / 2;

  double get _candleHeight => (_candleBottom - _candleTop) * animation.value;

  Offset get _candleCenter => Offset(candlestick.centerX, _candleCenterY);

  Rect get _candlestickRect => Rect.fromCenter(center: _candleCenter, width: _candleWith, height: _candleHeight);

  RRect get candlestickRRect => RRect.fromRectAndRadius(_candlestickRect, CandlestickMathHelperModel.radius);
}
