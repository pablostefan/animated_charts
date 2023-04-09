import 'package:animated_charts/models/candlestick_data_model.dart';
import 'package:animated_charts/models/candlestick_stock_performance_model.dart';
import 'package:flutter/material.dart';

class PositionHelperModel {
  final CandlestickStockPerformanceModel stockData;
  final Size size;
  final double? cursorPosition;

  PositionHelperModel({
    required this.stockData,
    required this.size,
    required this.cursorPosition,
  });

  double get _widthPerUnit => size.width / (stockData.data.length - 1);

  int get selectedIndex {
    if (cursorPosition == null) return stockData.data.length - 1;

    int selectedIndex = cursorPosition! ~/ _widthPerUnit;

    if (selectedIndex < 0) return 0;

    if (selectedIndex >= stockData.data.length) return stockData.data.length - 1;

    return selectedIndex;
  }

  double get axisX => _widthPerUnit * selectedIndex;

  CandlestickDataModel get selectedData => stockData.data[selectedIndex];
}
