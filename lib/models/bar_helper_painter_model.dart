import 'package:animated_charts/helpers/chart_colors.dart';
import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/bar_model.dart';
import 'package:animated_charts/models/stock_time_performance_model.dart';
import 'package:animated_charts/models/stock_time_window_model.dart';
import 'package:flutter/material.dart';

class BarHelperPainterModel {
  final StockTimeFramePerformanceModel? stockData;

  Paint get _gainPaint => Paint()..color = ChartColors.amountTransactionHistory;

  Paint get _lossPaint => Paint()..color = ChartColors.candlestickRedColor;

  double get _barWidth => ChartDimens.xpico;

  BarHelperPainterModel({required this.stockData});

  List<BarModel> generateBars(Size availableSpace) {
    final double pixelsPerTimeWindow = availableSpace.width / (stockData!.timeWindow.length - 1);
    final double pixelsPerStockOrder = availableSpace.height / stockData!.maxWindowVolume;

    List<BarModel> bars = [];

    for (int i = 0; i < stockData!.timeWindow.length; ++i) {
      StockTimeWindowModel window = stockData!.timeWindow[i];
      double barHeight = window.volume * pixelsPerStockOrder;
      double barCenterX = i * pixelsPerTimeWindow;
      Paint barPaint = window.isGain ? _gainPaint : _lossPaint;
      bars.add(BarModel(width: _barWidth, height: barHeight, paint: barPaint, centerX: barCenterX));
    }

    return bars;
  }

  static double getBarLeft(BarModel bar) => bar.centerX - bar.width / 2;

  static double getBarTop(BarModel bar, Size size) => size.height - bar.height;
}
