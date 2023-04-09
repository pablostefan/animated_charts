import 'dart:math';

import 'package:animated_charts/models/candlestick_data_model.dart';
import 'package:intl/intl.dart';

class TextHelperModel {
  static String candlestickInfo(CandlestickDataModel candlestickDataModel) {
    return "Abertura: ${candlestickDataModel.open.moneyMask()}\nFechamento: ${candlestickDataModel.close.moneyMask()}\nMáximo: ${candlestickDataModel.high.moneyMask()}\nMínimo: ${candlestickDataModel.low.moneyMask()}\nVolume: ${candlestickDataModel.volume}";
  }
}

extension Money on double? {
  String moneyMask({int decimalDigits = 2}) {
    return NumberFormat.simpleCurrency(
      name: "R\$",
      decimalDigits: decimalDigits,
    ).format(this?.truncateDouble(decimalDigits) ?? 0);
  }
}

extension TruncateDouble on double {
  double truncateDouble(int precision) {
    final mod = pow(10.0, precision);

    try {
      return (((abs() * mod).floor()) / mod);
    } catch (e) {
      return 0;
    }
  }
}
