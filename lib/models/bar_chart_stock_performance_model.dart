import 'package:animated_charts/models/bar_chart_model.dart';

class BarChartStockPerformanceModel {
  final List<BarChartModel> data;
  double _minValue = double.maxFinite;
  double _maxValue = double.minPositive;

  BarChartStockPerformanceModel({required this.data}) {
    for (BarChartModel barChartData in data) {
      if (barChartData.value > _maxValue) _maxValue = barChartData.value;
      if (barChartData.value < _minValue) _minValue = barChartData.value;
    }
  }

  double get minValue => _minValue;

  double get maxValue => _maxValue;
}
