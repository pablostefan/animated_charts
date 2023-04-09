import 'package:animated_charts/helpers/chart_colors.dart';
import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/helpers/position_helper_model.dart';
import 'package:animated_charts/models/bar_model.dart';
import 'package:animated_charts/models/candlestick_data_model.dart';
import 'package:animated_charts/models/candlestick_math_helper_model.dart';
import 'package:animated_charts/models/candlestick_stock_performance_model.dart';
import 'package:flutter/material.dart';

class BarHelperPainterModel {
  final CandlestickStockPerformanceModel stockData;
  final Animation<double> animation;
  final Size size;
  final double? cursorPosition;
  final bool showTooltip;

  late final PositionHelperModel _position;
  late final CandlestickMathHelperModel _mathHelper;

  BarHelperPainterModel({
    required this.stockData,
    required this.animation,
    required this.size,
    this.cursorPosition,
    required this.showTooltip,
  }) {
    _mathHelper = CandlestickMathHelperModel(stockData: stockData, size: size);
    _position = PositionHelperModel(stockData: stockData, size: _mathHelper.size, cursorPosition: cursorPosition);
  }

  double get _barWidth {
    double barWidth = (_mathHelper.size.width / stockData.data.length) * .7;

    return barWidth > 7 ? 7 : barWidth;
  }

  double get _pixelsPerTimeWindow => _mathHelper.size.width / (stockData.data.length - 1);

  double get _pixelsPerStockOrder => size.height / stockData.maxWindowVolume;

  Paint get _unSelectedBarPaint => Paint()..color = ChartColors.darkBorder;

  Paint get _selectedGainPaint => Paint()
    ..color = ChartColors.mediumLightGreen
    ..maskFilter = const MaskFilter.blur(BlurStyle.solid, ChartDimens.xxxmicro);

  Paint get _selectedLossPaint => Paint()
    ..color = ChartColors.candlestickRedColor
    ..maskFilter = const MaskFilter.blur(BlurStyle.solid, ChartDimens.xxxmicro);

  Paint _barPaint(int index, bool isGain) {
    bool selectBar = showTooltip && index == _position.selectedIndex;

    if (selectBar && isGain) return _selectedGainPaint;
    if (selectBar && !isGain) return _selectedLossPaint;
    return _unSelectedBarPaint;
  }

  Offset _getBarCenter(int index, double barHeight) {
    double barCenterX = index * _pixelsPerTimeWindow;
    double barCenterY = size.height - barHeight / 2;

    return Offset(barCenterX, barCenterY);
  }

  BarModel getBarModel(int index) {
    CandlestickDataModel window = stockData.data[index];
    double barHeight = window.volume * _pixelsPerStockOrder * animation.value;
    Offset barCenter = _getBarCenter(index, barHeight);

    return BarModel(
        barRect: Rect.fromCenter(center: barCenter, width: _barWidth, height: barHeight),
        barPaint: _barPaint(index, window.isGain));
  }
}
