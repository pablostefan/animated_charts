import 'package:animated_charts/models/candlestick_math_helper_model.dart';
import 'package:animated_charts/models/candlestick_paint_dimens_model.dart';
import 'package:flutter/material.dart';

class WickHelperPainterModel {
  final CandlestickPaintDimensModel candlestick;
  final Size size;
  final Animation<double> animation;

  WickHelperPainterModel({required this.candlestick, required this.size, required this.animation});

  double get _candleCenterX => candlestick.centerX * animation.value;

  double get _halfWickWith => CandlestickMathHelperModel.wickWith / 2;

  double get _wickLeft => _candleCenterX - _halfWickWith;

  double get _wickRight => _candleCenterX + _halfWickWith;

  double get _wickTop => size.height - candlestick.wickHighY;

  double get _wickBottom => size.height - candlestick.wickLowY;

  Rect get wickRect => Rect.fromLTRB(_wickLeft, _wickTop, _wickRight, _wickBottom);
}
