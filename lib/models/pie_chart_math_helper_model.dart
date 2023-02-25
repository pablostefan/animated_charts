import 'dart:math';

import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/pie_chart_model.dart';
import 'package:animated_charts/models/pie_chart_stock_performance_model.dart';
import 'package:flutter/material.dart';

class PieChartMathHelperModel {
  final PieChartStockPerformanceModel stockData;
  final Size size;

  PieChartMathHelperModel({required this.stockData, required this.size});

  double get _axisXCenter => size.width / 2;

  double get _axisYCenter => size.height / 2;

  static double get _unselectedRadius => height / 2;

  static double get _selectedRadius => height / 1.8;

  double getRadius(PieChartModel pieChart) => pieChart.isSelected ? _selectedRadius : _unselectedRadius;

  static double _getRadius(PieChartModel pieChart) => pieChart.isSelected ? _selectedRadius : _unselectedRadius;

  Offset get center => Offset(_axisXCenter, _axisYCenter);

  static double get height => ChartDimens.slgiant;

  static double get horizontalMargin => ChartDimens.xxxs;

  static double get strokeWidth => ChartDimens.xxxs;

  static double get selectedStrokeWidth => ChartDimens.xxs;

  static Offset _arcCenter(BuildContext context) {
    double arcCenterX = MediaQuery.of(context).size.width / 2 - horizontalMargin;
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

    double effectiveArcRadiusMax = arcRadius + pieChart.strokeWidth / 2;
    double effectiveArcRadiusMin = arcRadius - pieChart.strokeWidth / 2;

    double distanceFromCenter = sqrt(pointXOffset * pointXOffset + pointYOffset * pointYOffset);

    if (!(distanceFromCenter < effectiveArcRadiusMax && distanceFromCenter > effectiveArcRadiusMin)) return false;

    double angleFromCenter = atan2(pointYOffset, pointXOffset);

    if (angleFromCenter < 0) angleFromCenter += 2 * pi;

    double arcEndAngle = arcStartAngle + arcSweepAngle;

    if (arcStartAngle < 0) arcStartAngle += 2 * pi;

    if (arcEndAngle < 0) arcEndAngle += 2 * pi;

    if (arcStartAngle <= angleFromCenter && angleFromCenter <= arcEndAngle) return true;

    return false;
  }
}
