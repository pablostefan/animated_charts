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
  late TextPainter textPainter;

  TooltipHelperPainterModel({
    required this.size,
    required this.cursorPosition,
    required this.stockData,
    required this.animation,
  }) {
    _positionHelper = SelectedPositionMathHelperModel(stockData: stockData, size: size, cursorPosition: cursorPosition);
    textPainter = _buildValuesTextPainter(_valueText);
    textPainter.layout(minWidth: 0, maxWidth: _maxWidthValuesText);
  }

  double get _maxWidthValuesText => ChartDimens.xxxlg;

  TextStyle get _valuesTextStyle {
    Color textColor = ChartColors.monoWhite.withOpacity(animation.value);

    return TextStyle(color: textColor, fontSize: ChartDimens.micro);
  }

  String get _valueText => _positionHelper.selectedData.value.moneyMask();

  Paint get rectPaint => Paint()
    ..color = Colors.black26.withOpacity(animation.value * 0.5)
    ..style = PaintingStyle.fill;

  double get _tooltipWidth => ChartDimens.sm;

  double get _tooltipHeight => ChartDimens.sm;

  double get _tooltipBottom => _positionHelper.axisY - ChartDimens.micro;

  double get _tooltipBottomTranslate => _positionHelper.axisY + ChartDimens.micro + _tooltipHeight;

  double get _tooltipLeft => _positionHelper.axisX - _tooltipWidth;

  double get _tooltipLeftTranslate => size.width - _tooltipWidth * 2;

  double get _tooltipRight => _positionHelper.axisX + _tooltipWidth;

  double get _tooltipRightTranslate => _tooltipWidth * 2;

  double get _tooltipTop => _tooltipBottom - _tooltipHeight;

  double get _tooltipTopTranslate => _positionHelper.axisY + ChartDimens.micro;

  Offset get tooltipTopLeftOffset {
    if (_tooltipLeft < 0 && _tooltipTop < 0) return Offset(0, _tooltipTopTranslate);
    if (_tooltipRight > size.width && _tooltipTop < 0) return Offset(_tooltipLeftTranslate, _tooltipTopTranslate);
    if (_tooltipLeft < 0) return Offset(0, _tooltipTop);
    if (_tooltipRight > size.width) return Offset(_tooltipLeftTranslate, _tooltipTop);
    if (_tooltipTop < 0) return Offset(_tooltipLeft, _tooltipTopTranslate);
    return Offset(_tooltipLeft, _tooltipTop);
  }

  Offset get tooltipBottomRightOffset {
    if (_tooltipRight > size.width && _tooltipRight > size.width) return Offset(size.width, _tooltipBottomTranslate);
    if (_tooltipLeft < 0 && _tooltipTop < 0) return Offset(_tooltipRightTranslate, _tooltipBottomTranslate);
    if (_tooltipLeft < 0) return Offset(_tooltipRightTranslate, _tooltipBottom);
    if (_tooltipRight > size.width) return Offset(size.width, _tooltipBottom);
    if (_tooltipTop < 0) return Offset(_tooltipRight, _tooltipBottomTranslate);
    return Offset(_tooltipRight, _tooltipBottom);
  }

  RRect get tooltipRRect {
    return RRect.fromLTRBR(
      tooltipTopLeftOffset.dx,
      tooltipTopLeftOffset.dy,
      tooltipBottomRightOffset.dx,
      tooltipBottomRightOffset.dy,
      const Radius.circular(ChartDimens.micro),
    );
  }

  Offset get tooltipTextOffset {
    double axisX = tooltipTopLeftOffset.dx + ChartDimens.micro;
    double axisY = tooltipTopLeftOffset.dy + ChartDimens.micro;

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
