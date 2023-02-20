import 'package:animated_charts/models/line_chart_data_model.dart';

class LineChartStockPerformanceModel {
  final List<LineChartDataModel> data;
  double _minValue = double.maxFinite;
  double _maxValue = double.minPositive;

  LineChartStockPerformanceModel({required this.data}) {
    for (LineChartDataModel lineChartData in data) {
      if (lineChartData.value > _maxValue) _maxValue = lineChartData.value;
      if (lineChartData.value < _minValue) _minValue = lineChartData.value;
    }
  }

  double get minValue => _minValue;

  double get maxValue => _maxValue;
}
