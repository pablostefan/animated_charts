import 'package:animated_charts/helpers/chart_colors.dart';
import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/helpers/mask_money.dart';
import 'package:animated_charts/models/candlestick_helper_painter_model.dart';
import 'package:animated_charts/models/stock_time_performance_model.dart';
import 'package:flutter/material.dart';

class ValueTexHelperPainterModel {
  final StockTimeFramePerformanceModel? stockData;
  final Animation<double> animation;
  final int index;
  late TextPainter textPainter;
  final Size size;

  ValueTexHelperPainterModel({
    required this.stockData,
    required this.index,
    required this.animation,
    required this.size,
  }) {
    textPainter = _buildValuesTextPainter(_valueText);
    textPainter.layout(minWidth: 0, maxWidth: _maxWidthValuesText);
  }

  double get _high => stockData?.high ?? 0;

  double get _low => stockData?.low ?? 0;

  double get _maxWidthValuesText => ChartDimens.xxxlg;

  double get _spread => _high - _low;

  double get _distance => _spread / CandlesticksChartHelperPainterModel.numberLines;

  String get _valueText => '${_high - index * _distance}'.moneyMask();

  TextStyle get _valuesTextStyle {
    Color textColor = ChartColors.monoBlack.withOpacity(animation.value);

    return TextStyle(color: textColor, fontSize: ChartDimens.micro);
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

  Offset get valuesTextOffset {
    double axisX = _getValuesTextAxisX(size);
    double axisY = (index * CandlesticksChartHelperPainterModel.heightDistance) - textPainter.height / 2;
    Offset offset = Offset(axisX, axisY);

    return offset;
  }
}
