import 'package:animated_charts/stores/charts_store.dart';
import 'package:animated_charts/widgets/bar_chart_widget/bar_chart_widget.dart';
import 'package:animated_charts/widgets/candlestick_widget/candlestick_widget.dart';
import 'package:animated_charts/widgets/line_chart_widget/line_chart_widget.dart';
import 'package:animated_charts/widgets/stock_volume_widget/stock_volume_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';

class ChartsPage extends StatefulWidget {
  const ChartsPage({Key? key}) : super(key: key);

  @override
  State<ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  final ChartsStore _store = ChartsStore();

  @override
  Widget build(BuildContext context) {
    return TripleBuilder(
        store: _store,
        builder: (context, triple) => Scaffold(
                body: ListView(children: [
              CandlestickWidget(stockData: _store.state.stockDataCandlestick),
              StockVolumeWidget(stockData: _store.state.stockDataCandlestick),
              LineChartWidget(stockData: _store.state.stockDataLineChart),
              BarChartWidget(stockData: _store.state.stockDataBarChart)
            ])));
  }
}
