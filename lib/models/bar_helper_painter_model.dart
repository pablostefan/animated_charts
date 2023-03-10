import 'package:animated_charts/helpers/chart_colors.dart';
import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/bar_model.dart';
import 'package:animated_charts/models/candlestick_data_model.dart';
import 'package:animated_charts/models/candlestick_stock_performance_model.dart';
import 'package:flutter/material.dart';

class BarHelperPainterModel {
  final CandlestickStockPerformanceModel? stockData;
  final Animation<double> animation;
  final Size size;

  BarHelperPainterModel({required this.stockData, required this.animation, required this.size});

  double get _pixelsPerTimeWindow => size.width / (stockData!.data.length - 1);

  double get _pixelsPerStockOrder => size.height / stockData!.maxWindowVolume;

  Paint get _gainPaint => Paint()..color = ChartColors.amountTransactionHistory;

  Paint get _lossPaint => Paint()..color = ChartColors.candlestickRedColor;

  double get _barWidth => ChartDimens.xpico;

  double _getBarCenterX(int index) => index * _pixelsPerTimeWindow * animation.value;

  BarModel _getBarModel(int index) {
    CandlestickDataModel window = stockData!.data[index];
    double barHeight = window.volume * _pixelsPerStockOrder;
    double barCenterX = _getBarCenterX(index);
    Paint barPaint = window.isGain ? _gainPaint : _lossPaint;

    return BarModel(width: _barWidth, height: barHeight, paint: barPaint, centerX: barCenterX);
  }

  List<BarModel> get generateBars {
    List<BarModel> bars = stockData!.data.map((_) => _getBarModel(stockData!.data.indexOf(_))).toList();

    return bars;
  }

  static double getBarLeft(BarModel bar) => bar.centerX - bar.width / 2;

  static double getBarTop(BarModel bar, Size size) => size.height - bar.height;
}
