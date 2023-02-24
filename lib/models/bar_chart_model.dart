import 'package:flutter/material.dart';

class BarChartModel {
  final String date;
  final double value;

  BarChartModel({required this.date, required this.value});

  Color get color {
    if (value > 0) return Colors.green;
    if (value < 0) return Colors.red;
    return Colors.grey;
  }
}
