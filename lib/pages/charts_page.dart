import 'package:animated_charts/stores/charts_store.dart';
import 'package:animated_charts/widgets/bar_chart/bar_chart_widget.dart';
import 'package:animated_charts/widgets/candlestick/candlestick_widget.dart';
import 'package:animated_charts/widgets/line_chart/line_chart_widget.dart';
import 'package:animated_charts/widgets/pie_chart/pie_chart_widget.dart';
import 'package:animated_charts/widgets/stock_volume/stock_volume_widget.dart';
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
              PieChartWidget(stockData: _store.state.stockDataPieChart),
              CandlestickWidget(stockData: _store.state.stockDataCandlestick),
              StockVolumeWidget(stockData: _store.state.stockDataCandlestick),
              LineChartWidget(stockData: _store.state.stockDataLineChart),
              BarChartWidget(stockData: _store.state.stockDataBarChart),
            ])));
  }
}
