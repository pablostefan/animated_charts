import 'package:animated_charts/models/bar_chart_model.dart';

class BarChartStockPerformanceModel {
  final List<BarChartModel> data;
  double _maxValue = double.minPositive;

  BarChartStockPerformanceModel({required this.data}) {
    for (BarChartModel barChartData in data) {
      if (barChartData.value.abs() > _maxValue) _maxValue = barChartData.value.abs();
    }
  }

  double get maxValue => _maxValue;
}
