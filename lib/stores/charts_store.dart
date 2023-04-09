import 'package:animated_charts/helpers/candlestick_helpers.dart';
import 'package:animated_charts/models/candlestick_stock_performance_model.dart';
import 'package:animated_charts/views_model/charts_view_model.dart';
import 'package:mobx_triple/mobx_triple.dart';

class ChartsStore extends MobXStore<Exception, ChartsViewModel> {
  ChartsStore() : super(ChartsViewModel());

  void onTabTimeFrame(TimeFrame timeFrame) async {
    setLoading(true);
    await _setPageData(timeFrame);
    setLoading(false);
  }

  Future<void> _setPageData(TimeFrame timeFrame) async {
    await Future.delayed(const Duration(seconds: 1), () {
      _setTimeFrame(timeFrame);
      _setCandlestickData();
      _executeState();
    });
  }

  void _setTimeFrame(TimeFrame timeFrame) => state.selectedTimeFrame = timeFrame;

  void _setCandlestickData() => state.stockDataCandlestick = _candlestickData;

  CandlestickStockPerformanceModel get _candlestickData {
    switch (state.selectedTimeFrame) {
      case TimeFrame.oneHour:
        return CandlestickStockPerformanceModel(data: state.oneHour);
      case TimeFrame.oneDay:
        return CandlestickStockPerformanceModel(data: state.oneDay);
      case TimeFrame.oneWeek:
        return CandlestickStockPerformanceModel(data: state.oneWeek);
      case TimeFrame.oneMonth:
        return CandlestickStockPerformanceModel(data: state.oneMonth);
      case TimeFrame.oneYear:
        return CandlestickStockPerformanceModel(data: state.oneYear);
      case TimeFrame.all:
        return CandlestickStockPerformanceModel(data: state.all);
    }
  }

  void _executeState() => execute(() async => state, delay: const Duration(milliseconds: 0));
}
