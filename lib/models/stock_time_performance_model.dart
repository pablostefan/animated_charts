import 'dart:math';

import 'package:animated_charts/helpers/candlestick_helpers.dart';
import 'package:animated_charts/models/stock_time_window_model.dart';

class StockTimeFramePerformanceModel {
  final List<StockTimeWindowModel> timeWindow;
  late double _open;
  late double _close;
  late double _high;
  late double _low;
  late double _volume;
  late double _maxWindowVolume;

  StockTimeFramePerformanceModel({required this.timeWindow}) : assert(timeWindow.isNotEmpty) {
    _open = timeWindow.first.open;
    _close = timeWindow.last.close;
    _high = timeWindow.first.high;
    _low = timeWindow.first.low;
    _volume = timeWindow.first.volume;
    _maxWindowVolume = _volume;

    for (int i = 0; i < timeWindow.length; ++i) {
      if (timeWindow[i].high > _high) _high = timeWindow[i].high;
      if (timeWindow[i].low < _low) _low = timeWindow[i].low;

      _volume += timeWindow[i].volume;

      _maxWindowVolume = max(_maxWindowVolume, timeWindow[i].volume);
    }
  }

  double get open => _open;

  double get close => _close;

  double get high => _high;

  double get low => _low;

  double get volume => _volume;

  double get maxWindowVolume => _maxWindowVolume;

  PriceChange get priceChange => _close >= _open ? PriceChange.gain : PriceChange.loss;

  double get dollarChange => _close - _open;

  double get percentageChange => (dollarChange / _open) * 100;
}
