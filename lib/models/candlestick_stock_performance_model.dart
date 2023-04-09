import 'dart:math';

import 'package:animated_charts/helpers/candlestick_helpers.dart';
import 'package:animated_charts/models/candlestick_data_model.dart';

class CandlestickStockPerformanceModel {
  List<CandlestickDataModel> data;
  late double _open;
  late double _close;
  late double _high;
  late double _low;
  late double _volume;
  late double _maxWindowVolume;

  CandlestickStockPerformanceModel({required this.data}) : assert(data.isNotEmpty) {
    _open = data.first.open;
    _close = data.last.close;
    _high = data.first.high;
    _low = data.first.low;
    _volume = data.first.volume;
    _maxWindowVolume = _volume;

    for (CandlestickDataModel candlestick in data) {
      if (candlestick.high > _high) _high = candlestick.high;
      if (candlestick.low < _low) _low = candlestick.low;
      _volume += candlestick.volume;
      _maxWindowVolume = max(_maxWindowVolume, candlestick.volume);
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
