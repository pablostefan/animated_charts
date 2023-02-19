import 'package:animated_charts/models/candlestick_helper_painter_model.dart';
import 'package:animated_charts/models/candlestick_paint_dimens_model.dart';
import 'package:flutter/material.dart';

class CandleHelperPainterModel {
  final CandlestickPaintDimensModel candlestick;
  final Size size;
  final Animation<double> animation;

  CandleHelperPainterModel({required this.candlestick, required this.size, required this.animation});

  double get _candleCenterX {
    if (animation.value == 0) return 1;
    return candlestick.centerX / animation.value;
  }

  double get _candleLeft => _candleCenterX - CandlesticksChartHelperPainterModel.candleWith / 2;

  double get _candleRight => _candleCenterX + CandlesticksChartHelperPainterModel.candleWith / 2;

  double get _candleTop => size.height - candlestick.candleHighY;

  double get _candleBottom => size.height - candlestick.candleLowY;

  Rect get _candlestickRect => Rect.fromLTRB(_candleLeft, _candleTop, _candleRight, _candleBottom);

  RRect get candlestickRRect => RRect.fromRectAndRadius(_candlestickRect, CandlesticksChartHelperPainterModel.radius);
}
