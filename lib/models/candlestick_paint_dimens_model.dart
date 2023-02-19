import 'package:flutter/material.dart';

class CandlestickPaintDimensModel {
  final double centerX;
  final double wickHighY;
  final double wickLowY;
  final double candleHighY;
  final double candleLowY;
  final Paint candlePaint;

  CandlestickPaintDimensModel({
    required this.centerX,
    required this.candleHighY,
    required this.candleLowY,
    required this.candlePaint,
    required this.wickHighY,
    required this.wickLowY,
  });
}
