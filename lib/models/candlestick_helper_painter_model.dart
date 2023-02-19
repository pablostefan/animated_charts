import 'package:animated_charts/helpers/chart_colors.dart';
import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/candlestick_paint_dimens_model.dart';
import 'package:animated_charts/models/stock_time_performance_model.dart';
import 'package:animated_charts/models/stock_time_window_model.dart';
import 'package:animated_charts/widgets/foxbit_wallet_candlestick_widget/candlestick_widget.dart';
import 'package:flutter/material.dart';

class CandlesticksChartHelperPainterModel {
  final Size _size;
  final StockTimeFramePerformanceModel stockData;

  CandlesticksChartHelperPainterModel({required Size size, required this.stockData}) : _size = _getNewSize(size);

  static Radius get radius => const Radius.circular(ChartDimens.xatto);

  static double get wickWith => ChartDimens.xxhetter;

  static double get candleWith => ChartDimens.xxfemto;

  static double get leftPadding => ChartDimens.xxl;

  static double get numberLines => ChartDimens.femto;

  static double get heightDistance => CandlestickWidget.height / (numberLines - 1);

  static double get linesDifferencePadding => ChartDimens.xxxmicro;

  static Paint get _gainPaint => Paint()..color = ChartColors.mediumLightGreen;

  static Paint get _lossPaint => Paint()..color = ChartColors.candlestickRedColor;

  double get _pixelsPerTimeWindow => _size.width / (stockData.timeWindow.length - 1);

  double get _pixelsPerDollar => _size.height / (stockData.high - stockData.low);

  Size get size => _size;

  static Size _getNewSize(Size size) {
    double newWidth = size.width - CandlesticksChartHelperPainterModel.leftPadding;
    return Size(newWidth, size.height);
  }

  CandlestickPaintDimensModel _getCandlestick(int index) {
    StockTimeWindowModel window = stockData.timeWindow[index];
    double candlestickCenterX = index * _pixelsPerTimeWindow;
    double wickHighY = (window.high - stockData.low) * _pixelsPerDollar;
    double wickLowY = (window.low - stockData.low) * _pixelsPerDollar;
    double candleHighY = (window.open - stockData.low) * _pixelsPerDollar;
    double candleLowY = (window.close - stockData.low) * _pixelsPerDollar;
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
    var candles = stockData.timeWindow.map((_) => _getCandlestick(stockData.timeWindow.indexOf(_))).toList();

    return candles;
  }
}
