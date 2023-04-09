import 'package:animated_charts/helpers/chart_colors.dart';
import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/helpers/position_helper_model.dart';
import 'package:animated_charts/models/candlestick_data_model.dart';
import 'package:animated_charts/models/candlestick_math_helper_model.dart';
import 'package:animated_charts/models/candlestick_paint_dimens_model.dart';
import 'package:animated_charts/models/candlestick_stock_performance_model.dart';
import 'package:flutter/material.dart';

class CandlesticksChartHelperPainterModel {
  final CandlestickStockPerformanceModel stockData;
  late final CandlestickMathHelperModel _mathHelper;
  late final PositionHelperModel _position;
  final double? cursorPosition;
  final bool showTooltip;

  CandlesticksChartHelperPainterModel({
    required Size size,
    required this.stockData,
    this.cursorPosition,
    this.showTooltip = false,
  }) {
    _mathHelper = CandlestickMathHelperModel(size: size, stockData: stockData);
    _position = PositionHelperModel(stockData: stockData, size: _mathHelper.size, cursorPosition: cursorPosition);
  }

  Size get size => _mathHelper.size;

  Paint get _gainPaint => Paint()..color = ChartColors.mediumLightGreen;

  Paint get _selectedGainPaint => Paint()
    ..color = ChartColors.mediumLightGreen
    ..maskFilter = const MaskFilter.blur(BlurStyle.solid, ChartDimens.xxxmicro);

  Paint get _lossPaint => Paint()..color = ChartColors.candlestickRedColor;

  Paint get _selectedLossPaint => Paint()
    ..color = ChartColors.candlestickRedColor
    ..maskFilter = const MaskFilter.blur(BlurStyle.solid, ChartDimens.xxxmicro);

  Paint _candlePaint(int index, bool isGain) {
    bool isSelect = _position.selectedIndex == index;

    if (isSelect && isGain && showTooltip) return _selectedGainPaint;
    if (isSelect && !isGain && showTooltip) return _selectedLossPaint;
    if (isGain) return _gainPaint;
    return _lossPaint;
  }

  CandlestickPaintDimensModel _getCandlestick(int index) {
    CandlestickDataModel window = stockData.data[index];
    double candlestickCenterX = index * _mathHelper.pixelsPerTimeWindow;
    double wickHighY = (window.high - stockData.low) * _mathHelper.pixelsPerDollar;
    double wickLowY = (window.low - stockData.low) * _mathHelper.pixelsPerDollar;
    double candleHighY = (window.open - stockData.low) * _mathHelper.pixelsPerDollar;
    double candleLowY = (window.close - stockData.low) * _mathHelper.pixelsPerDollar;
    Paint candlePaint = _candlePaint(index, window.isGain);

    return CandlestickPaintDimensModel(
        centerX: candlestickCenterX,
        candleHighY: candleHighY,
        candleLowY: candleLowY,
        wickHighY: wickHighY,
        wickLowY: wickLowY,
        candlePaint: candlePaint);
  }

  List<CandlestickPaintDimensModel> get generateCandlesticks {
    var candles = stockData.data.map((_) => _getCandlestick(stockData.data.indexOf(_))).toList();

    return candles;
  }
}
