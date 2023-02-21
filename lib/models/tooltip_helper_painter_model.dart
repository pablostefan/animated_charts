import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/line_chart_stock_performance_model.dart';
import 'package:flutter/material.dart';

class TooltipHelperPainterModel {
  final Size size;
  final double? cursorPosition;
  final LineChartStockPerformanceModel stockData;
  final Animation<double> animation;

  TooltipHelperPainterModel({
    required this.size,
    required this.cursorPosition,
    required this.stockData,
    required this.animation,
  });

  Paint get rectPaint => Paint()
    ..color = Colors.black26.withOpacity(animation.value)
    ..style = PaintingStyle.fill;

  double get _tooltipWidth => ChartDimens.xxxllg;

  double get _tooltipHeight => ChartDimens.xxxllg;

  double get _widthPerUnit => size.width / (stockData.data.length - 1);

  double get _heightPerUnit => size.height / (stockData.maxValue - stockData.minValue);

  int get _selectedIndex {
    if (cursorPosition == null) return stockData.data.length - 1;
    return cursorPosition! ~/ _widthPerUnit;
  }

  double get _axisX => _widthPerUnit * _selectedIndex;

  double get _axisY {
    double lineChartDataValue = stockData.data[_selectedIndex].value;

    return size.height - (lineChartDataValue - stockData.minValue) * _heightPerUnit;
  }

  double get _tooltipBottom => _axisY - ChartDimens.micro;

  double get _tooltipLeft => _axisX - _tooltipWidth;

  double get _tooltipLeftTranslate => size.width - _tooltipWidth * 2;

  double get _tooltipRight => _axisX + _tooltipWidth;

  double get _tooltipRightTranslate => _tooltipWidth * 2;

  double get _tooltipTop => _tooltipBottom - _tooltipHeight;

  Offset get tooltipTopLeftOffset {
    if (_tooltipLeft < 0) return Offset(0, _tooltipTop);
    if (_tooltipRight > size.width) return Offset(_tooltipLeftTranslate, _tooltipTop);
    return Offset(_tooltipLeft, _tooltipTop);
  }

  Offset get tooltipBottomRightOffset {
    if (_tooltipLeft < 0) return Offset(_tooltipRightTranslate, _tooltipBottom);
    if (_tooltipRight > size.width) return Offset(size.width, _tooltipBottom);
    return Offset(_tooltipRight, _tooltipBottom);
  }

  RRect get tooltipRRect {
    print(tooltipTopLeftOffset.dx);
    print(tooltipBottomRightOffset.dx);
    return RRect.fromLTRBR(
      tooltipTopLeftOffset.dx,
      tooltipTopLeftOffset.dy,
      tooltipBottomRightOffset.dx,
      tooltipBottomRightOffset.dy,
      const Radius.circular(ChartDimens.micro),
    );
  }
}
