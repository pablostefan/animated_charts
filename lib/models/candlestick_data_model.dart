class CandlestickDataModel {
  final DateTime dateTime;
  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;

  CandlestickDataModel({
    required this.dateTime,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });
}
