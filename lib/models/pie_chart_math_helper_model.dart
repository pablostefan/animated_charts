import 'dart:math';

import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/pie_chart_model.dart';
import 'package:animated_charts/models/pie_chart_stock_performance_model.dart';
import 'package:flutter/material.dart';

class PieChartMathHelperModel {
  final PieChartStockPerformanceModel stockData;
  final Size size;

  PieChartMathHelperModel({required this.stockData, required this.size});

  double get axisXCenter => size.width / 2;

  double get axisYCenter => size.height / 2;

  static double get _unselectedRadius => height / 2;

  static double get _selectedRadius => height / 1.8;

  double getRadius(PieChartModel pieChart) => pieChart.isSelected ? _selectedRadius : _unselectedRadius;

  static double _getRadius(PieChartModel pieChart) => pieChart.isSelected ? _selectedRadius : _unselectedRadius;

  Offset get center => Offset(axisXCenter, axisYCenter);

  static double get height => ChartDimens.slgiant;

  static double get strokeWidth => ChartDimens.xxxs;

  static double get selectedStrokeWidth => ChartDimens.xxs;

  static Offset _arcCenter(BuildContext context) {
    double arcCenterX = MediaQuery.of(context).size.width / 2;
    double arcCenterY = height / 2;

    return Offset(arcCenterX, arcCenterY);
  }

  static bool isPointInArc(
    Offset point,
    PieChartModel pieChart,
    BuildContext context,
  ) {
    Offset arcCenter = _arcCenter(context);
    double arcRadius = _getRadius(pieChart);

    double arcStartAngle = pieChart.startAngle;
    double arcSweepAngle = pieChart.sweepAngle;

    double pointXOffset = point.dx - arcCenter.dx;
    double pointYOffset = point.dy - arcCenter.dy;

    double strokeWidth = pieChart.strokeWidth + ChartDimens.nano;
    double effectiveArcRadiusMax = arcRadius + strokeWidth / 2 + ChartDimens.nano;
    double effectiveArcRadiusMin = arcRadius - strokeWidth / 2 - ChartDimens.nano;

    double arcEndAngle = arcStartAngle + arcSweepAngle;

    double distanceFromCenter = sqrt(pointXOffset * pointXOffset + pointYOffset * pointYOffset);

    double angleFromCenter = atan2(pointYOffset, pointXOffset);

    if (distanceFromCenter > effectiveArcRadiusMax || distanceFromCenter < effectiveArcRadiusMin) return false;

    if (angleFromCenter < 0) angleFromCenter += 2 * pi;

    if (arcStartAngle < 0) arcStartAngle += 2 * pi;

    if (arcEndAngle < 0) arcEndAngle += 2 * pi;

    if (arcStartAngle <= angleFromCenter && angleFromCenter <= arcEndAngle) return true;

    return false;
  }
}
