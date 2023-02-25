import 'dart:math';

import 'package:animated_charts/models/pie_chart_model.dart';
import 'package:flutter/material.dart';

class PieChartStockPerformanceModel {
  List<PieChartModel> data;
  late double _totalPercentage;
  bool correctPercentage = true;

  PieChartStockPerformanceModel({required this.data}) {
    _setTotalPercentage();
    _shortData();
    _setAngles();
  }

  void _setAngles() {
    double startAngle = 0;
    for (PieChartModel element in data) {
      element.setStartAngle(startAngle);
      element.setSweepAngle(2 * pi * element.percentage / _totalPercentage);
      startAngle += element.sweepAngle;
    }
  }

  void _setTotalPercentage() {
    _totalPercentage = data.fold(0, (previousValue, element) => previousValue + element.percentage);
    if (_totalPercentage > 100) _setCorrectPercentage(false);
    if (_totalPercentage < 100) _addUnknownData();
  }

  void _setCorrectPercentage(bool correctPercentage) => this.correctPercentage = correctPercentage;

  void _addUnknownData() {
    data.add(_unknownPieChartModel);
    _totalPercentage = 100;
  }

  void _shortData() => data.sort((a, b) => b.percentage.compareTo(a.percentage));

  PieChartModel get _unknownPieChartModel {
    return PieChartModel(percentage: 100 - _totalPercentage, name: 'unknown', color: Colors.black);
  }

  double get totalPercentage => _totalPercentage;
}
