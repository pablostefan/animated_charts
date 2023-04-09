import 'package:animated_charts/helpers/chart_colors.dart';
import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/helpers/position_helper_model.dart';
import 'package:animated_charts/helpers/text_helper_model.dart';
import 'package:animated_charts/models/candlestick_helper_painter_model.dart';
import 'package:animated_charts/models/candlestick_math_helper_model.dart';
import 'package:animated_charts/models/candlestick_paint_dimens_model.dart';
import 'package:animated_charts/models/candlestick_stock_performance_model.dart';
import 'package:flutter/material.dart';

class TooltipHelperPainterModel {
  final double? cursorPosition;
  final CandlestickStockPerformanceModel stockData;
  final Animation<double> animation;
  final List<CandlestickPaintDimensModel> candlesticks;
  final CandlesticksChartHelperPainterModel painterHelper;
  late final PositionHelperModel _position;
  late final CandlestickMathHelperModel _mathHelper;
  late TextPainter _textPainter;

  TooltipHelperPainterModel({
    required Size size,
    required this.cursorPosition,
    required this.stockData,
    required this.animation,
    required this.candlesticks,
    required this.painterHelper,
  }) {
    _mathHelper = CandlestickMathHelperModel(stockData: stockData, size: size);
    _position = PositionHelperModel(stockData: stockData, size: _mathHelper.size, cursorPosition: cursorPosition);
    _textPainter = _buildValuesTextPainter(_valueText);
    _textPainter.layout(minWidth: 0);
  }

  Size get size => _mathHelper.size;

  String get _valueText => TextHelperModel.candlestickInfo(_position.selectedData);

  Paint get rectShadowPaint => Paint()
    ..color = ChartColors.darkSymbolColor.withOpacity(ChartDimens.xxhetter)
    ..maskFilter = const MaskFilter.blur(BlurStyle.outer, ChartDimens.micro)
    ..style = PaintingStyle.fill;

  Paint get rectPaint => Paint()
    ..color = ChartColors.darkSymbolColor.withOpacity(ChartDimens.xxxletter)
    ..style = PaintingStyle.fill;

  TextPainter get textPainter => _textPainter;

  double get _candleTop => size.height - candlesticks[_position.selectedIndex].candleHighY;

  double get _candleBottom => size.height - candlesticks[_position.selectedIndex].candleLowY;

  double get _candleCenterY => (_candleTop + _candleBottom) / 2;

  double get _candleHeight => (_candleBottom - _candleTop).abs() / 2;

  double get _tooltipWidth => (_textPainter.width + ChartDimens.micro) / 2;

  double get _tooltipHeight => _textPainter.height + ChartDimens.micro;

  double get _tooltipBottom => _candleCenterY - _candleHeight - ChartDimens.xxxs;

  double get _tooltipBottomTranslate => _tooltipTopTranslate + _tooltipHeight;

  double get _tooltipLeft => _position.axisX - _tooltipWidth;

  double get _tooltipLeftTranslate => size.width - _tooltipWidth * 2;

  double get _tooltipRight => _position.axisX + _tooltipWidth;

  double get _tooltipRightTranslate => _tooltipWidth * 2;

  double get _tooltipTop => _tooltipBottom - _tooltipHeight;

  double get _tooltipTopTranslate => _candleCenterY + _candleHeight + ChartDimens.xxxs;

  Offset get _tooltipTopLeftOffset {
    if (_tooltipLeft < 0 && _tooltipTop < 0) return Offset(0, _tooltipTopTranslate);
    if (_tooltipRight > size.width && _tooltipTop < 0) return Offset(_tooltipLeftTranslate, _tooltipTopTranslate);
    if (_tooltipLeft < 0) return Offset(0, _tooltipTop);
    if (_tooltipRight > size.width) return Offset(_tooltipLeftTranslate, _tooltipTop);
    if (_tooltipTop < 0) return Offset(_tooltipLeft, _tooltipTopTranslate);
    return Offset(_tooltipLeft, _tooltipTop);
  }

  Offset get _tooltipBottomRightOffset {
    if (_tooltipLeft < 0 && _tooltipTop < 0) return Offset(_tooltipRightTranslate, _tooltipBottomTranslate);
    if (_tooltipRight > size.width && _tooltipTop < 0) return Offset(size.width, _tooltipBottomTranslate);
    if (_tooltipLeft < 0) return Offset(_tooltipRightTranslate, _tooltipBottom);
    if (_tooltipRight > size.width) return Offset(size.width, _tooltipBottom);
    if (_tooltipTop < 0) return Offset(_tooltipRight, _tooltipBottomTranslate);
    return Offset(_tooltipRight, _tooltipBottom);
  }

  RRect get tooltipRRect {
    return RRect.fromLTRBR(
      _tooltipTopLeftOffset.dx,
      _tooltipTopLeftOffset.dy,
      _tooltipBottomRightOffset.dx,
      _tooltipBottomRightOffset.dy,
      const Radius.circular(ChartDimens.micro),
    );
  }

  Offset get tooltipTextOffset {
    double axisXDiff = (_tooltipWidth * 2 - _textPainter.width) / 2;
    double axisYDiff = (_tooltipHeight - _textPainter.height) / 2;
    double axisX = _tooltipTopLeftOffset.dx + axisXDiff;
    double axisY = _tooltipTopLeftOffset.dy + axisYDiff;

    return Offset(axisX, axisY);
  }

  TextSpan _buildValuesTextSpan(String text) => TextSpan(text: text);

  TextPainter _buildValuesTextPainter(String text) {
    return TextPainter(text: _buildValuesTextSpan(text), textDirection: TextDirection.ltr, textAlign: TextAlign.left);
  }
}
