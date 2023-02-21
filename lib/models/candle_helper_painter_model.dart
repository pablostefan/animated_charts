import 'package:animated_charts/models/candlestick_math_helper_model.dart';
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

  double get _halfCandleWith => CandlestickMathHelperModel.candleWith / 2;

  double get _candleLeft => _candleCenterX - _halfCandleWith;

  double get _candleRight => _candleCenterX + _halfCandleWith;

  double get _candleTop => size.height - candlestick.candleHighY;

  double get _candleBottom => size.height - candlestick.candleLowY;

  Rect get _candlestickRect => Rect.fromLTRB(_candleLeft, _candleTop, _candleRight, _candleBottom);

  RRect get candlestickRRect => RRect.fromRectAndRadius(_candlestickRect, CandlestickMathHelperModel.radius);
}
