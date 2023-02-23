import 'package:animated_charts/helpers/chart_colors.dart';
import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/helpers/mask_money.dart';
import 'package:animated_charts/models/line_chart_stock_performance_model.dart';
import 'package:animated_charts/models/selected_position_math_helper_model.dart';
import 'package:flutter/material.dart';

class TooltipHelperPainterModel {
  final Size size;
  final double? cursorPosition;
  final LineChartStockPerformanceModel stockData;
  final Animation<double> animation;
  late final SelectedPositionMathHelperModel _positionHelper;
  late TextPainter _textPainter;

  TooltipHelperPainterModel({
    required this.size,
    required this.cursorPosition,
    required this.stockData,
    required this.animation,
  }) {
    _positionHelper = SelectedPositionMathHelperModel(stockData: stockData, size: size, cursorPosition: cursorPosition);
    _textPainter = _buildValuesTextPainter(_valueText);
    _textPainter.layout(minWidth: 0, maxWidth: _maxWidthValuesText);
  }

  double get _maxWidthValuesText => ChartDimens.xxxlg;

  TextStyle get _valuesTextStyle {
    Color textColor = ChartColors.monoBlack.withOpacity(animation.value);

    return TextStyle(color: textColor, fontSize: ChartDimens.micro);
  }

  String get _valueText => _positionHelper.selectedData.value.moneyMask();

  Paint get rectPaint => Paint()
    ..color = ChartColors.mediumLightGreen.withOpacity(animation.value * 0.5)
    ..style = PaintingStyle.fill;

  TextPainter get textPainter => _textPainter;

  double get _tooltipWidth => (_textPainter.width + ChartDimens.micro) / 2;

  double get _tooltipHeight => _textPainter.height + ChartDimens.micro;

  double get _tooltipBottom => _positionHelper.axisY - ChartDimens.micro;

  double get _tooltipBottomTranslate => _positionHelper.axisY + ChartDimens.micro + _tooltipHeight;

  double get _tooltipLeft => _positionHelper.axisX - _tooltipWidth;

  double get _tooltipLeftTranslate => size.width - _tooltipWidth * 2;

  double get _tooltipRight => _positionHelper.axisX + _tooltipWidth;

  double get _tooltipRightTranslate => _tooltipWidth * 2;

  double get _tooltipTop => _tooltipBottom - _tooltipHeight;

  double get _tooltipTopTranslate => _positionHelper.axisY + ChartDimens.micro;

  Offset get _tooltipTopLeftOffset {
    if (_tooltipLeft < 0 && _tooltipTop < 0) return Offset(0, _tooltipTopTranslate);
    if (_tooltipRight > size.width && _tooltipTop < 0) return Offset(_tooltipLeftTranslate, _tooltipTopTranslate);
    if (_tooltipLeft < 0) return Offset(0, _tooltipTop);
    if (_tooltipRight > size.width) return Offset(_tooltipLeftTranslate, _tooltipTop);
    if (_tooltipTop < 0) return Offset(_tooltipLeft, _tooltipTopTranslate);
    return Offset(_tooltipLeft, _tooltipTop);
  }

  Offset get _tooltipBottomRightOffset {
    if (_tooltipRight > size.width && _tooltipRight > size.width) return Offset(size.width, _tooltipBottomTranslate);
    if (_tooltipLeft < 0 && _tooltipTop < 0) return Offset(_tooltipRightTranslate, _tooltipBottomTranslate);
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
