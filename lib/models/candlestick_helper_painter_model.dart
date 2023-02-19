import 'package:animated_charts/helpers/chart_colors.dart';
import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/candlestick_paint_dimens_model.dart';
import 'package:animated_charts/models/stock_time_performance_model.dart';
import 'package:animated_charts/models/stock_time_window_model.dart';
import 'package:animated_charts/widgets/foxbit_wallet_candlestick_widget/stock_candlestick_widget.dart';
import 'package:flutter/material.dart';

class CandlesticksChartHelperPainterModel {
  static Radius get radius => const Radius.circular(ChartDimens.xatto);

  static double get wickWith => ChartDimens.xxhetter;

  static double get candleWith => ChartDimens.xxfemto;

  static double get leftPadding => ChartDimens.xxl;

  static double get numberLines => ChartDimens.femto;

  static double get heightDistance => StockCandlestickWidget.height / (numberLines - 1);

  static double get linesDifferencePadding => ChartDimens.xxxmicro;

  static Paint get _gainPaint => Paint()..color = ChartColors.mediumLightGreen;

  static Paint get _lossPaint => Paint()..color = ChartColors.candlestickRedColor;

  static Size getNewSize(Size size) {
    double newWidth = size.width - CandlesticksChartHelperPainterModel.leftPadding;
    return Size(newWidth, size.height);
  }

  static List<CandlestickPaintDimensModel> generateCandlesticks(
    Size availableSpace,
    StockTimeFramePerformanceModel? stockData,
  ) {
    final double pixelsPerTimeWindow = availableSpace.width / (stockData!.timeWindow.length - 1);
    final double pixelsPerDollar = availableSpace.height / (stockData.high - stockData.low);

    List<CandlestickPaintDimensModel> candlesticks = [];

    for (int i = 0; i < stockData.timeWindow.length; ++i) {
      StockTimeWindowModel window = stockData.timeWindow[i];
      double candlestickCenterX = i * pixelsPerTimeWindow;
      double wickHighY = (window.high - stockData.low) * pixelsPerDollar;
      double wickLowY = (window.low - stockData.low) * pixelsPerDollar;
      double candleHighY = (window.open - stockData.low) * pixelsPerDollar;
      double candleLowY = (window.close - stockData.low) * pixelsPerDollar;
      Paint candlePaint = window.isGain ? _gainPaint : _lossPaint;

      candlesticks.add(CandlestickPaintDimensModel(
          centerX: candlestickCenterX,
          candleHighY: candleHighY,
          candleLowY: candleLowY,
          wickHighY: wickHighY,
          wickLowY: wickLowY,
          candlePaint: candlePaint));
    }

    return candlesticks;
  }
}
