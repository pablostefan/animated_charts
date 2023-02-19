import 'package:animated_charts/helpers/chart_colors.dart';
import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/helpers/mask_money.dart';
import 'package:animated_charts/models/candlestick_helper_painter_model.dart';
import 'package:flutter/material.dart';

class ValueTexHelperPainterModel {
  final double? high;
  final double? low;
  final int index;
  late TextPainter textPainter;

  ValueTexHelperPainterModel({required this.high, required this.low, required this.index}) {
    textPainter = _buildValuesTextPainter(_valueText);
    textPainter.layout(minWidth: 0, maxWidth: _maxWidthValuesText);
  }

  double get _maxWidthValuesText => ChartDimens.xxxlg;

  double get _spread => (high ?? 0) - (low ?? 0);

  double get _distance => _spread / CandlesticksChartHelperPainterModel.numberLines;

  String get _valueText => '${high ?? 0 - index * _distance}'.moneyMask();

  TextStyle get _valuesTextStyle {
    return const TextStyle(color: ChartColors.candlestickValuesColor, fontSize: ChartDimens.micro);
  }

  double get _valuesTextLinesPadding => ChartDimens.nano;

  double _getValuesTextAxisX(Size size) => _getLinesWidth(size) + _valuesTextLinesPadding;

  double _getLinesWidth(Size size) {
    return size.width -
        CandlesticksChartHelperPainterModel.leftPadding +
        CandlesticksChartHelperPainterModel.linesDifferencePadding;
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

  Offset getValuesTextOffset(int index, Size size) {
    double axisX = _getValuesTextAxisX(size);
    double axisY = (index * CandlesticksChartHelperPainterModel.heightDistance) - textPainter.height / 2;
    Offset offset = Offset(axisX, axisY);

    return offset;
  }
}
