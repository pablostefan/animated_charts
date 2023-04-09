import 'package:animated_charts/models/candlestick_paint_dimens_model.dart';
import 'package:animated_charts/models/candlestick_stock_performance_model.dart';
import 'package:flutter/material.dart';

class WickHelperPainterModel {
  final CandlestickPaintDimensModel candlestick;
  final Size size;
  final Animation<double> animation;
  final CandlestickStockPerformanceModel stockData;

  WickHelperPainterModel({
    required this.candlestick,
    required this.size,
    required this.animation,
    required this.stockData,
  });

  double get _wickWith {
    double wickWith = (size.width / stockData.data.length) * .15;

    return wickWith > 1 ? 1 : wickWith;
  }

  double get _wickTop => size.height - candlestick.wickHighY;

  double get _wickBottom => size.height - candlestick.wickLowY;

  double get _wickCenterY => (_wickTop + _wickBottom) / 2;

  double get _wickHeight => (_wickBottom - _wickTop) * animation.value;

  Offset get _wickCenter => Offset(candlestick.centerX, _wickCenterY);

  Rect get wickRect => Rect.fromCenter(center: _wickCenter, width: _wickWith, height: _wickHeight);
}
