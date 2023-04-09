import 'package:animated_charts/helpers/chart_colors.dart';
import 'package:animated_charts/stores/charts_store.dart';
import 'package:animated_charts/widgets/bar_chart/bar_chart_widget.dart';
import 'package:animated_charts/widgets/candlestick/candlestick_widget.dart';
import 'package:animated_charts/widgets/line_chart/line_chart_widget.dart';
import 'package:animated_charts/widgets/pie_chart/pie_chart_widget.dart';
import 'package:animated_charts/widgets/stock_dates_widget/stock_dates_widget.dart';
import 'package:animated_charts/widgets/water_percentage/water_percentage_widget.dart';
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
    return Stack(alignment: Alignment.topCenter, children: [
      TripleBuilder(
          store: _store,
          builder: (context, triple) => Scaffold(
              backgroundColor: ChartColors.darkSliverAppBarColor,
              body: ListView(children: [
                const WaterPercentageWidget(percentage: .5),
                PieChartWidget(stockData: _store.state.stockDataPieChart),
                LineChartWidget(stockData: _store.state.stockDataLineChart),
                BarChartWidget(stockData: _store.state.stockDataBarChart),
                CandlestickWidget(
                    stockData: _store.state.stockDataCandlestick,
                    timeFrame: _store.state.selectedTimeFrame,
                    isLoading: _store.isLoading),
                StockDatesWidget(
                    onTapTimeFrame: _store.onTabTimeFrame, selectedTimeFrame: _store.state.selectedTimeFrame),
              ]))),
    ]);
  }
}
