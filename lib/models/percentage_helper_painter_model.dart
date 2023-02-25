import 'package:animated_charts/helpers/chart_colors.dart';
import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/pie_chart_math_helper_model.dart';
import 'package:animated_charts/models/pie_chart_model.dart';
import 'package:animated_charts/models/pie_chart_stock_performance_model.dart';
import 'package:flutter/material.dart';

class PercentageHelperPainterModel {
  final PieChartStockPerformanceModel stockData;
  final Size size;
  final Animation<double> animation;
  late TextPainter _percentageTextPainter;
  late TextPainter _nameTextPainter;
  late final PieChartMathHelperModel _mathHelper;

  PercentageHelperPainterModel({required this.stockData, required this.size, required this.animation}) {
    _mathHelper = PieChartMathHelperModel(stockData: stockData, size: size);
    _percentageTextPainter = _buildValuesTextPainter(_percentageValueText);
    _nameTextPainter = _buildValuesTextPainter(_nameText);
    _percentageTextPainter.layout(minWidth: 0, maxWidth: double.infinity);
    _nameTextPainter.layout(minWidth: 0, maxWidth: double.infinity);
  }

  TextPainter get percentageTextPainter => _percentageTextPainter;

  TextPainter get nameTextPainter => _nameTextPainter;

  Offset get percentageTextOffset {
    double axisX = _mathHelper.axisXCenter - _percentageTextPainter.width / 2;
    double axisY = _mathHelper.axisYCenter - _percentageTextPainter.height;

    return Offset(axisX, axisY);
  }

  Offset get nameTextOffset {
    double axisX = _mathHelper.axisXCenter - _nameTextPainter.width / 2;
    double axisY = _mathHelper.axisYCenter;

    return Offset(axisX, axisY);
  }

  TextStyle get _valuesTextStyle {
    Color textColor = ChartColors.monoBlack.withOpacity(animation.value);

    return TextStyle(color: textColor, fontSize: ChartDimens.sm);
  }

  String get _nameText {
    List<PieChartModel> hesSelected = stockData.data.where((element) => element.isSelected).toList();
    if (hesSelected.isNotEmpty) return hesSelected.first.name;

    return "Total";
  }

  String get _percentageValueText {
    bool hesSelected = stockData.data.any((element) => element.isSelected);
    if (hesSelected) return _selectedPercentageText;
    return _percentageText;
  }

  String get _percentageText => "${stockData.totalPercentage} %";

  String get _selectedPercentageText {
    double percentage = stockData.data.firstWhere((element) => element.isSelected).percentage;

    return "$percentage %";
  }

  TextPainter _buildValuesTextPainter(String text) {
    return TextPainter(
        strutStyle: StrutStyle.fromTextStyle(_valuesTextStyle),
        text: _buildValuesTextSpan(text),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left,
        maxLines: 1);
  }

  TextSpan _buildValuesTextSpan(String text) => TextSpan(text: text, style: _valuesTextStyle);
}
