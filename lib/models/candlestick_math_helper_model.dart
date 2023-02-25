import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/candlestick_stock_performance_model.dart';
import 'package:animated_charts/widgets/candlestick/candlestick_widget.dart';
import 'package:flutter/material.dart';

class CandlestickMathHelperModel {
  final Size _size;
  final CandlestickStockPerformanceModel stockData;

  CandlestickMathHelperModel({required Size size, required this.stockData}) : _size = _getNewSize(size);

  static Size _getNewSize(Size size) {
    double newWidth = size.width - leftPadding;
    return Size(newWidth, size.height);
  }

  double getAxisY(int index) => index * heightDistance;

  double get linesWidth => size.width + _linesDifferencePadding;

  double get _linesDifferencePadding => ChartDimens.xxxmicro;

  static Radius get radius => const Radius.circular(ChartDimens.xatto);

  static double get wickWith => ChartDimens.xxhetter;

  static double get candleWith => ChartDimens.xxfemto;

  static double get leftPadding => ChartDimens.xxl;

  static double get numberLines => ChartDimens.femto;

  static double get heightDistance => CandlestickWidget.height / (numberLines - 1);

  static double get linesDifferencePadding => ChartDimens.xxxmicro;

  double get pixelsPerTimeWindow => _size.width / (stockData.data.length - 1);

  double get pixelsPerDollar => _size.height / (stockData.high - stockData.low);

  Size get size => _size;

  double get _valuesTextLinesPadding => ChartDimens.nano;

  double get valuesTextAxisX => linesWidth + _valuesTextLinesPadding;

  double getTextAxisY(int index, double textHeight) => (index * heightDistance) - textHeight / 2;
}
