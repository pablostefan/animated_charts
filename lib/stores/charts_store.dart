import 'package:animated_charts/views_model/charts_view_model.dart';
import 'package:mobx_triple/mobx_triple.dart';

class ChartsStore extends MobXStore<Exception, ChartsViewModel> {
  ChartsStore() : super(ChartsViewModel());
}
