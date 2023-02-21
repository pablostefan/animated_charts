import 'package:animated_charts/helpers/chart_colors.dart';
import 'package:animated_charts/models/candlestick_data_model.dart';
import 'package:animated_charts/models/candlestick_math_helper_model.dart';
import 'package:animated_charts/models/candlestick_paint_dimens_model.dart';
import 'package:animated_charts/models/candlestick_stock_performance_model.dart';
import 'package:flutter/material.dart';

class CandlesticksChartHelperPainterModel {
  final CandlestickStockPerformanceModel stockData;
  late final CandlestickMathHelperModel _mathHelper;

  CandlesticksChartHelperPainterModel({required Size size, required this.stockData}) {
    _mathHelper = CandlestickMathHelperModel(size: size, stockData: stockData);
  }

  Size get size => _mathHelper.size;

  Paint get _gainPaint => Paint()..color = ChartColors.mediumLightGreen;

  Paint get _lossPaint => Paint()..color = ChartColors.candlestickRedColor;

  CandlestickPaintDimensModel _getCandlestick(int index) {
    CandlestickDataModel window = stockData.data[index];
    double candlestickCenterX = index * _mathHelper.pixelsPerTimeWindow;
    double wickHighY = (window.high - stockData.low) * _mathHelper.pixelsPerDollar;
    double wickLowY = (window.low - stockData.low) * _mathHelper.pixelsPerDollar;
    double candleHighY = (window.open - stockData.low) * _mathHelper.pixelsPerDollar;
    double candleLowY = (window.close - stockData.low) * _mathHelper.pixelsPerDollar;
    Paint candlePaint = window.isGain ? _gainPaint : _lossPaint;

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
