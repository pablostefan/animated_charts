import 'package:animated_charts/stores/candlestick_chart_store.dart';
import 'package:animated_charts/widgets/line_chart_widget/line_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';

class CandlestickChartPage extends StatefulWidget {
  const CandlestickChartPage({Key? key}) : super(key: key);

  @override
  State<CandlestickChartPage> createState() => _CandlestickChartPageState();
}

class _CandlestickChartPageState extends State<CandlestickChartPage> {
  final CandlestickChartStore _store = CandlestickChartStore();

  @override
  Widget build(BuildContext context) {
    return TripleBuilder(
        store: _store,
        builder: (context, triple) => Scaffold(
                body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              // CandlestickWidget(stockData: _store.state.stockData),
              // StockVolumeWidget(stockData: _store.state.stockData),

              LineChartWidget(stockData: _store.state.stockDataLineChart),
            ])));
  }
}
