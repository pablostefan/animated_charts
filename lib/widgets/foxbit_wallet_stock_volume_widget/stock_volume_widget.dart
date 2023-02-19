import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/stock_time_performance_model.dart';
import 'package:animated_charts/widgets/foxbit_wallet_stock_volume_widget/stock_volume_painter.dart';
import 'package:flutter/material.dart';

class StockVolumeWidget extends StatelessWidget {
  final StockTimeFramePerformanceModel? stockData;
  final EdgeInsetsGeometry margin;

  const StockVolumeWidget({
    required this.stockData,
    Key? key,
    this.margin = const EdgeInsets.only(right: ChartDimens.xxxs, left: ChartDimens.xxxs, top: ChartDimens.nano),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ChartDimens.smxss,
        margin: margin,
        child: CustomPaint(size: Size.infinite, painter: StockVolumePainter(stockData: stockData)));
  }
}
