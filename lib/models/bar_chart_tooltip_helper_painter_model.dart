import 'package:animated_charts/helpers/chart_colors.dart';
import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/helpers/mask_money.dart';
import 'package:animated_charts/models/bar_char_selected_position_helper_model.dart';
import 'package:animated_charts/models/bar_chart_stock_performance_model.dart';
import 'package:flutter/material.dart';

class BarChartTooltipHelperPainterModel {
  final Size size;
  final Offset? cursorPosition;
  final BarChartStockPerformanceModel stockData;
  final Animation<double> animation;
  late final BarChartSelectedPositionHelperModel _position;
  late TextPainter _textPainter;

  BarChartTooltipHelperPainterModel({
    required this.size,
    required this.cursorPosition,
    required this.stockData,
    required this.animation,
  }) {
    _position = BarChartSelectedPositionHelperModel(stockData: stockData, size: size, cursorPosition: cursorPosition);
    _textPainter = _buildValuesTextPainter(_valueText);
    _textPainter.layout(minWidth: 0, maxWidth: _maxWidthValuesText);
  }

  double get _maxWidthValuesText => ChartDimens.xxxlg;

  TextStyle get _valuesTextStyle {
    Color textColor = ChartColors.monoBlack;

    return TextStyle(color: textColor, fontSize: ChartDimens.micro);
  }

  String get _valueText => _position.selectedData.value.moneyMask();

  Color get _tooltipBackgroundColor {
    return _position.positiveValue
        ? ChartColors.mediumLightGreen.withOpacity(animation.value * 0.5)
        : ChartColors.darkError.withOpacity(animation.value * 0.5);
  }

  Paint get rectPaint => Paint()
    ..color = _tooltipBackgroundColor
    ..style = PaintingStyle.fill;

  TextPainter get textPainter => _textPainter;

  bool get showTooltip => _position.cursorInsideChart;

  double get _tooltipWidth => (_textPainter.width + ChartDimens.micro) / 2;

  double get _tooltipHeight => _textPainter.height + ChartDimens.micro;

  double get _positiveTooltipBottom => _positiveTooltipTop - _tooltipHeight;

  double get _tooltipLeft => _position.centerX - _tooltipWidth;

  double get _tooltipLeftTranslate => size.width - _tooltipWidth * 2;

  double get _tooltipRight => _position.centerX + _tooltipWidth;

  double get _tooltipRightTranslate => _tooltipWidth * 2;

  double get _positiveTooltipTop => ChartDimens.xxs;

  double get _negativeTooltipTop => size.height;

  double get _negativeTooltipBottom => _negativeTooltipTop - _tooltipHeight;

  Offset get _positiveTooltipPositiveTopLeftOffset {
    if (_tooltipLeft < 0) return Offset(0, _positiveTooltipTop);
    if (_tooltipRight > size.width) return Offset(_tooltipLeftTranslate, _positiveTooltipTop);

    return Offset(_tooltipLeft, _positiveTooltipTop);
  }

  Offset get _positiveTooltipBottomRightOffset {
    if (_tooltipLeft < 0) return Offset(_tooltipRightTranslate, _positiveTooltipBottom);
    if (_tooltipRight > size.width) return Offset(size.width, _positiveTooltipBottom);

    return Offset(_tooltipRight, _positiveTooltipBottom);
  }

  Offset get _negativeTooltipTopLeftOffset {
    if (_tooltipLeft < 0) return Offset(0, _negativeTooltipTop);
    if (_tooltipRight > size.width) return Offset(_tooltipLeftTranslate, _negativeTooltipTop);

    return Offset(_tooltipLeft, _negativeTooltipTop);
  }

  Offset get _negativeTooltipPositiveBottomRightOffset {
    if (_tooltipLeft < 0) return Offset(_tooltipRightTranslate, _negativeTooltipBottom);
    if (_tooltipRight > size.width) return Offset(size.width, _negativeTooltipBottom);

    return Offset(_tooltipRight, _negativeTooltipBottom);
  }

  Offset get _tooltipTopLeftOffset {
    if (_position.positiveValue) return _positiveTooltipPositiveTopLeftOffset;
    return _negativeTooltipTopLeftOffset;
  }

  Offset get _tooltipBottomRightOffset {
    if (_position.positiveValue) return _positiveTooltipBottomRightOffset;
    return _negativeTooltipPositiveBottomRightOffset;
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
    double axisY = _tooltipBottomRightOffset.dy + axisYDiff;

    return Offset(axisX, axisY);
  }

  TextSpan _buildValuesTextSpan(String text) => TextSpan(text: text, style: _valuesTextStyle);

  TextPainter _buildValuesTextPainter(String text) {
    return TextPainter(
        strutStyle: StrutStyle.fromTextStyle(_valuesTextStyle),
        text: _buildValuesTextSpan(text),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left,
        maxLines: 1);
  }
}
