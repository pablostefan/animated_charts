import 'package:animated_charts/helpers/candlestick_helpers.dart';
import 'package:animated_charts/models/bar_chart_model.dart';
import 'package:animated_charts/models/bar_chart_stock_performance_model.dart';
import 'package:animated_charts/models/candlestick_data_model.dart';
import 'package:animated_charts/models/candlestick_stock_performance_model.dart';
import 'package:animated_charts/models/line_chart_data_model.dart';
import 'package:animated_charts/models/line_chart_stock_performance_model.dart';
import 'package:animated_charts/models/pie_chart_model.dart';
import 'package:animated_charts/models/pie_chart_stock_performance_model.dart';
import 'package:flutter/material.dart';

class ChartsViewModel {
  TimeFrame selectedTimeFrame = TimeFrame.oneHour;

  CandlestickStockPerformanceModel stockDataCandlestick = CandlestickStockPerformanceModel(data: [
    CandlestickDataModel(low: 1372, high: 1382.6, close: 1374.12, open: 1381.46, volume: 94212),
    CandlestickDataModel(low: 1372, high: 1400, close: 1374.12, open: 1381.46, volume: 94212),
    CandlestickDataModel(low: 1377, high: 1386, close: 1381, open: 1385, volume: 54122),
    CandlestickDataModel(low: 1376.03, high: 1384.6, close: 1376.12, open: 1383.46, volume: 84212),
    CandlestickDataModel(low: 1379, high: 1389.6, close: 1388.06, open: 1386.4, volume: 54122),
    CandlestickDataModel(low: 1372.03, high: 1380.6, close: 1375.12, open: 1372.46, volume: 84212),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1372, high: 1382.6, close: 1374.12, open: 1381.46, volume: 94212),
    CandlestickDataModel(low: 1377, high: 1386, close: 1381, open: 1385, volume: 54122),
    CandlestickDataModel(low: 1376.03, high: 1384.6, close: 1376.12, open: 1383.46, volume: 84212),
    CandlestickDataModel(low: 1379, high: 1389.6, close: 1388.06, open: 1386.4, volume: 54122),
    CandlestickDataModel(low: 1372.03, high: 1380.6, close: 1375.12, open: 1372.46, volume: 84212),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1372, high: 1382.6, close: 1374.12, open: 1381.46, volume: 94212),
    CandlestickDataModel(low: 1377, high: 1386, close: 1381, open: 1385, volume: 54122),
    CandlestickDataModel(low: 1376.03, high: 1384.6, close: 1376.12, open: 1383.46, volume: 84212),
    CandlestickDataModel(low: 1379, high: 1389.6, close: 1388.06, open: 1386.4, volume: 54122),
    CandlestickDataModel(low: 1372.03, high: 1380.6, close: 1375.12, open: 1372.46, volume: 84212),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1370, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
  ]);

  LineChartStockPerformanceModel stockDataLineChart = LineChartStockPerformanceModel(data: [
    LineChartDataModel(date: '', value: 900),
    LineChartDataModel(date: '', value: 150),
    LineChartDataModel(date: '', value: 300),
    LineChartDataModel(date: '', value: 600),
    LineChartDataModel(date: '', value: 100),
    LineChartDataModel(date: '', value: 700),
    LineChartDataModel(date: '', value: 300),
    LineChartDataModel(date: '', value: 800),
    LineChartDataModel(date: '', value: 800),
    LineChartDataModel(date: '', value: 900),
  ]);
  BarChartStockPerformanceModel stockDataBarChart = BarChartStockPerformanceModel(data: [
    BarChartModel(date: '', value: 1000),
    BarChartModel(date: '', value: 500),
    BarChartModel(date: '', value: 300),
    BarChartModel(date: '', value: 600),
    BarChartModel(date: '', value: 0),
    BarChartModel(date: '', value: -700),
    BarChartModel(date: '', value: 300),
    BarChartModel(date: '', value: -1000),
    BarChartModel(date: '', value: 800),
    BarChartModel(date: '', value: 900),
  ]);
  PieChartStockPerformanceModel stockDataPieChart = PieChartStockPerformanceModel(data: [
    PieChartModel(name: 'ETH', percentage: 20, color: Colors.blueAccent),
    PieChartModel(name: 'BTC', percentage: 5, color: Colors.redAccent),
    PieChartModel(name: 'ASA', percentage: 5, color: Colors.yellowAccent),
    PieChartModel(name: 'TSE', percentage: 20, color: Colors.greenAccent),
    PieChartModel(name: 'TSE', percentage: 5, color: Colors.brown),
    PieChartModel(name: 'TSE', percentage: 15, color: Colors.pinkAccent),
    PieChartModel(name: 'TSE', percentage: 10, color: Colors.purpleAccent),
    PieChartModel(name: 'TSE', percentage: 10, color: Colors.amberAccent),
  ]);

  List<CandlestickDataModel> oneHour = [
    CandlestickDataModel(low: 1372, high: 1382.6, close: 1374.12, open: 1381.46, volume: 94212),
    CandlestickDataModel(low: 1372, high: 1400, close: 1374.12, open: 1381.46, volume: 94212),
    CandlestickDataModel(low: 1377, high: 1386, close: 1381, open: 1385, volume: 54122),
    CandlestickDataModel(low: 1376.03, high: 1384.6, close: 1376.12, open: 1383.46, volume: 84212),
    CandlestickDataModel(low: 1379, high: 1389.6, close: 1388.06, open: 1386.4, volume: 54122),
    CandlestickDataModel(low: 1372.03, high: 1380.6, close: 1375.12, open: 1372.46, volume: 84212),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1372, high: 1382.6, close: 1374.12, open: 1381.46, volume: 94212),
    CandlestickDataModel(low: 1377, high: 1386, close: 1381, open: 1385, volume: 54122),
    CandlestickDataModel(low: 1376.03, high: 1384.6, close: 1376.12, open: 1383.46, volume: 84212),
    CandlestickDataModel(low: 1379, high: 1389.6, close: 1388.06, open: 1386.4, volume: 54122),
    CandlestickDataModel(low: 1372.03, high: 1380.6, close: 1375.12, open: 1372.46, volume: 84212),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1372, high: 1382.6, close: 1374.12, open: 1381.46, volume: 94212),
    CandlestickDataModel(low: 1377, high: 1386, close: 1381, open: 1385, volume: 54122),
    CandlestickDataModel(low: 1376.03, high: 1384.6, close: 1376.12, open: 1383.46, volume: 84212),
    CandlestickDataModel(low: 1379, high: 1389.6, close: 1388.06, open: 1386.4, volume: 54122),
    CandlestickDataModel(low: 1372.03, high: 1380.6, close: 1375.12, open: 1372.46, volume: 84212),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1370, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
  ];

  List<CandlestickDataModel> oneDay = [
    CandlestickDataModel(low: 1372, high: 1382.6, close: 1374.12, open: 1381.46, volume: 94212),
    CandlestickDataModel(low: 1372, high: 1400, close: 1374.12, open: 1381.46, volume: 94212),
    CandlestickDataModel(low: 1377, high: 1386, close: 1381, open: 1385, volume: 54122),
    CandlestickDataModel(low: 1376.03, high: 1384.6, close: 1376.12, open: 1383.46, volume: 84212),
    CandlestickDataModel(low: 1379, high: 1389.6, close: 1388.06, open: 1386.4, volume: 54122),
    CandlestickDataModel(low: 1372.03, high: 1380.6, close: 1375.12, open: 1372.46, volume: 84212),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1372, high: 1382.6, close: 1374.12, open: 1381.46, volume: 94212),
    CandlestickDataModel(low: 1377, high: 1386, close: 1381, open: 1385, volume: 54122),
    CandlestickDataModel(low: 1376.03, high: 1384.6, close: 1376.12, open: 1383.46, volume: 84212),
    CandlestickDataModel(low: 1379, high: 1389.6, close: 1388.06, open: 1386.4, volume: 54122),
    CandlestickDataModel(low: 1372.03, high: 1380.6, close: 1375.12, open: 1372.46, volume: 84212),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1372, high: 1382.6, close: 1374.12, open: 1381.46, volume: 94212),
    CandlestickDataModel(low: 1377, high: 1386, close: 1381, open: 1385, volume: 54122),
    CandlestickDataModel(low: 1376.03, high: 1384.6, close: 1376.12, open: 1383.46, volume: 84212),
  ];
  List<CandlestickDataModel> oneWeek = [
    CandlestickDataModel(low: 1372, high: 1382.6, close: 1374.12, open: 1381.46, volume: 94212),
    CandlestickDataModel(low: 1372, high: 1400, close: 1374.12, open: 1381.46, volume: 94212),
    CandlestickDataModel(low: 1377, high: 1386, close: 1381, open: 1385, volume: 54122),
    CandlestickDataModel(low: 1376.03, high: 1384.6, close: 1376.12, open: 1383.46, volume: 84212),
    CandlestickDataModel(low: 1379, high: 1389.6, close: 1388.06, open: 1386.4, volume: 54122),
    CandlestickDataModel(low: 1372.03, high: 1380.6, close: 1375.12, open: 1372.46, volume: 84212),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1372, high: 1382.6, close: 1374.12, open: 1381.46, volume: 94212),
    CandlestickDataModel(low: 1377, high: 1386, close: 1381, open: 1385, volume: 54122),
    CandlestickDataModel(low: 1376.03, high: 1384.6, close: 1376.12, open: 1383.46, volume: 84212),
    CandlestickDataModel(low: 1379, high: 1389.6, close: 1388.06, open: 1386.4, volume: 54122),
    CandlestickDataModel(low: 1372.03, high: 1380.6, close: 1375.12, open: 1372.46, volume: 84212),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1372, high: 1382.6, close: 1374.12, open: 1381.46, volume: 94212),
    CandlestickDataModel(low: 1377, high: 1386, close: 1381, open: 1385, volume: 54122),
    CandlestickDataModel(low: 1376.03, high: 1384.6, close: 1376.12, open: 1383.46, volume: 84212),
    CandlestickDataModel(low: 1372, high: 1382.6, close: 1374.12, open: 1381.46, volume: 94212),
    CandlestickDataModel(low: 1377, high: 1386, close: 1381, open: 1385, volume: 54122),
    CandlestickDataModel(low: 1376.03, high: 1384.6, close: 1376.12, open: 1383.46, volume: 84212),
    CandlestickDataModel(low: 1379, high: 1389.6, close: 1388.06, open: 1386.4, volume: 54122),
    CandlestickDataModel(low: 1372.03, high: 1380.6, close: 1375.12, open: 1372.46, volume: 84212),
  ];

  List<CandlestickDataModel> oneMonth = [
    CandlestickDataModel(low: 1372.03, high: 1380.6, close: 1375.12, open: 1372.46, volume: 84212),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1372, high: 1382.6, close: 1374.12, open: 1381.46, volume: 94212),
    CandlestickDataModel(low: 1377, high: 1386, close: 1381, open: 1385, volume: 54122),
    CandlestickDataModel(low: 1376.03, high: 1384.6, close: 1376.12, open: 1383.46, volume: 84212),
    CandlestickDataModel(low: 1379, high: 1389.6, close: 1388.06, open: 1386.4, volume: 54122),
    CandlestickDataModel(low: 1372.03, high: 1380.6, close: 1375.12, open: 1372.46, volume: 84212),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1372, high: 1382.6, close: 1374.12, open: 1381.46, volume: 94212),
    CandlestickDataModel(low: 1377, high: 1386, close: 1381, open: 1385, volume: 54122),
    CandlestickDataModel(low: 1376.03, high: 1384.6, close: 1376.12, open: 1383.46, volume: 84212),
    CandlestickDataModel(low: 1372, high: 1382.6, close: 1374.12, open: 1381.46, volume: 94212),
    CandlestickDataModel(low: 1377, high: 1386, close: 1381, open: 1385, volume: 54122),
    CandlestickDataModel(low: 1376.03, high: 1384.6, close: 1376.12, open: 1383.46, volume: 84212),
    CandlestickDataModel(low: 1379, high: 1389.6, close: 1388.06, open: 1386.4, volume: 54122),
    CandlestickDataModel(low: 1372.03, high: 1380.6, close: 1375.12, open: 1372.46, volume: 84212),
  ];

  List<CandlestickDataModel> oneYear = [
    CandlestickDataModel(low: 1372.03, high: 1380.6, close: 1375.12, open: 1372.46, volume: 84212),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1372, high: 1382.6, close: 1374.12, open: 1381.46, volume: 94212),
    CandlestickDataModel(low: 1377, high: 1386, close: 1381, open: 1385, volume: 54122),
    CandlestickDataModel(low: 1376.03, high: 1384.6, close: 1376.12, open: 1383.46, volume: 84212),
    CandlestickDataModel(low: 1379, high: 1389.6, close: 1388.06, open: 1386.4, volume: 54122),
    CandlestickDataModel(low: 1372.03, high: 1380.6, close: 1375.12, open: 1372.46, volume: 84212),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1372, high: 1382.6, close: 1374.12, open: 1381.46, volume: 94212),
    CandlestickDataModel(low: 1377, high: 1386, close: 1381, open: 1385, volume: 54122),
    CandlestickDataModel(low: 1376.03, high: 1384.6, close: 1376.12, open: 1383.46, volume: 84212),
    CandlestickDataModel(low: 1372, high: 1382.6, close: 1374.12, open: 1381.46, volume: 94212),
    CandlestickDataModel(low: 1377, high: 1386, close: 1381, open: 1385, volume: 54122),
    CandlestickDataModel(low: 1376.03, high: 1384.6, close: 1376.12, open: 1383.46, volume: 84212),
    CandlestickDataModel(low: 1379, high: 1389.6, close: 1388.06, open: 1386.4, volume: 54122),
    CandlestickDataModel(low: 1372.03, high: 1380.6, close: 1375.12, open: 1372.46, volume: 84212),
    CandlestickDataModel(low: 1377, high: 1386, close: 1381, open: 1385, volume: 54122),
    CandlestickDataModel(low: 1376.03, high: 1384.6, close: 1376.12, open: 1383.46, volume: 84212),
    CandlestickDataModel(low: 1379, high: 1389.6, close: 1388.06, open: 1386.4, volume: 54122),
    CandlestickDataModel(low: 1372.03, high: 1380.6, close: 1375.12, open: 1372.46, volume: 84212),
  ];

  List<CandlestickDataModel> all = [
    CandlestickDataModel(low: 1377, high: 1386, close: 1381, open: 1385, volume: 54122),
    CandlestickDataModel(low: 1376.03, high: 1384.6, close: 1376.12, open: 1383.46, volume: 84212),
    CandlestickDataModel(low: 1372, high: 1382.6, close: 1374.12, open: 1381.46, volume: 94212),
    CandlestickDataModel(low: 1372.03, high: 1380.6, close: 1375.12, open: 1372.46, volume: 84212),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1372, high: 1382.6, close: 1374.12, open: 1381.46, volume: 94212),
    CandlestickDataModel(low: 1377, high: 1386, close: 1381, open: 1385, volume: 54122),
    CandlestickDataModel(low: 1376.03, high: 1384.6, close: 1376.12, open: 1383.46, volume: 84212),
    CandlestickDataModel(low: 1379, high: 1389.6, close: 1388.06, open: 1386.4, volume: 54122),
    CandlestickDataModel(low: 1372.03, high: 1380.6, close: 1375.12, open: 1372.46, volume: 84212),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1375, high: 1382.6, close: 1379.06, open: 1382.4, volume: 58122),
    CandlestickDataModel(low: 1372, high: 1382.6, close: 1374.12, open: 1381.46, volume: 94212),
    CandlestickDataModel(low: 1377, high: 1386, close: 1381, open: 1385, volume: 54122),
    CandlestickDataModel(low: 1376.03, high: 1384.6, close: 1376.12, open: 1383.46, volume: 84212),
    CandlestickDataModel(low: 1372, high: 1382.6, close: 1374.12, open: 1381.46, volume: 94212),
    CandlestickDataModel(low: 1377, high: 1386, close: 1381, open: 1385, volume: 54122),
    CandlestickDataModel(low: 1376.03, high: 1384.6, close: 1376.12, open: 1383.46, volume: 84212),
    CandlestickDataModel(low: 1379, high: 1389.6, close: 1388.06, open: 1386.4, volume: 54122),
    CandlestickDataModel(low: 1372.03, high: 1380.6, close: 1375.12, open: 1372.46, volume: 84212),
    CandlestickDataModel(low: 1377, high: 1386, close: 1381, open: 1385, volume: 54122),
    CandlestickDataModel(low: 1376.03, high: 1384.6, close: 1376.12, open: 1383.46, volume: 84212),
    CandlestickDataModel(low: 1379, high: 1389.6, close: 1388.06, open: 1386.4, volume: 54122),
    CandlestickDataModel(low: 1372.03, high: 1380.6, close: 1375.12, open: 1372.46, volume: 84212),
  ];
}
