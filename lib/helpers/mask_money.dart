import 'dart:io';
import 'dart:math';

import 'package:intl/intl.dart';

enum Money { brl, usd }

final Map<String, String> currency = {Money.brl.type: "R\$", Money.usd.type: "\$", "": ""};

extension Type on Money {
  String get type => name.toUpperCase();
}

extension MoneyFormat on String? {
  String moneyMask({int decimalDigits = 2, String? symbol}) {
    return double.parse(this ?? "0").moneyMask(decimalDigits: decimalDigits, symbol: symbol);
  }
}

extension Decimal on String? {
  String decimal({int decimalDigits = 2}) =>
      NumberFormat.simpleCurrency(name: "", decimalDigits: decimalDigits).format(double.parse(this ?? "0"));
}

extension MoneyMask on double? {
  String moneyMask({int decimalDigits = 2, String? symbol}) => NumberFormat.simpleCurrency(
          locale: Platform.localeName, name: currency[symbol ?? "BRL"], decimalDigits: decimalDigits)
      .format(this?.chartTruncateToDouble(decimalDigits) ?? 0);
}

extension TruncateDouble on double {
  double chartTruncateToDouble(int precision) {
    final mod = pow(10.0, precision);
    return (((abs() * mod).floor()) / mod);
  }
}

extension TruncateString on double {
  String chartTruncateToString(int precision) {
    final mod = pow(10.0, precision);
    return (((abs() * mod).floor()) / mod).toString();
  }
}
