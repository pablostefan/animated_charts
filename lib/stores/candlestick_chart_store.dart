import 'package:animated_charts/views_model/candlestick_chart_view_model.dart';
import 'package:mobx_triple/mobx_triple.dart';

class CandlestickChartStore extends MobXStore<Exception, CandlestickChartViewModel> {
  CandlestickChartStore() : super(CandlestickChartViewModel());
}
