import 'package:animated_charts/helpers/chart_colors.dart';
import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/helpers/mask_money.dart';
import 'package:animated_charts/models/candlestick_math_helper_model.dart';
import 'package:animated_charts/models/candlestick_stock_performance_model.dart';
import 'package:flutter/material.dart';

class ValueTexHelperPainterModel {
  final CandlestickStockPerformanceModel? stockData;
  final Animation<double> animation;
  final int index;
  final Size size;
  late final CandlestickMathHelperModel _mathHelper;
  late TextPainter _textPainter;

  ValueTexHelperPainterModel({
    required this.stockData,
    required this.index,
    required this.animation,
    required this.size,
  }) {
    _textPainter = _buildValuesTextPainter(_valueText);
    _textPainter.layout(minWidth: 0, maxWidth: _maxWidthValuesText);
    _mathHelper = CandlestickMathHelperModel(size: size, stockData: stockData!);
  }

  double get _high => stockData?.high ?? 0;

  double get _low => stockData?.low ?? 0;

  double get _maxWidthValuesText => ChartDimens.xxxlg;

  double get _spread => _high - _low;

  double get _distance => _spread / CandlestickMathHelperModel.numberLines;

  String get _valueText => '${_high - index * _distance}'.moneyMask();

  TextStyle get _valuesTextStyle {
    Color textColor = ChartColors.darkTextAmount.withOpacity(animation.value);

    return TextStyle(color: textColor, fontSize: ChartDimens.micro);
  }

  TextPainter get textPainter => _textPainter;

  TextSpan _buildValuesTextSpan(String text) => TextSpan(text: text, style: _valuesTextStyle);

  TextPainter _buildValuesTextPainter(String text) {
    return TextPainter(
        strutStyle: StrutStyle.fromTextStyle(_valuesTextStyle),
        text: _buildValuesTextSpan(text),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left,
        maxLines: 1);
  }

  Offset get valuesTextOffset {
    double axisX = _mathHelper.valuesTextAxisX;
    double axisY = _mathHelper.getTextAxisY(index, textPainter.height);
    Offset offset = Offset(axisX, axisY);

    return offset;
  }
}
