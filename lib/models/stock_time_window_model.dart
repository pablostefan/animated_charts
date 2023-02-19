class StockTimeWindowModel {
  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;

  StockTimeWindowModel({
    required this.low,
    required this.high,
    required this.close,
    required this.open,
    required this.volume,
  });

  bool get isGain => close >= open;
}
