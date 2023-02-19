import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/stock_time_performance_model.dart';
import 'package:animated_charts/widgets/foxbit_wallet_stock_volume_widget/stock_volume_painter.dart';
import 'package:flutter/material.dart';

class StockVolumeWidget extends StatefulWidget {
  final StockTimeFramePerformanceModel? stockData;
  final EdgeInsetsGeometry margin;

  const StockVolumeWidget({
    required this.stockData,
    Key? key,
    this.margin = const EdgeInsets.only(right: ChartDimens.xxxs, left: ChartDimens.xxxs, top: ChartDimens.nano),
  }) : super(key: key);

  @override
  State<StockVolumeWidget> createState() => _StockVolumeWidgetState();
}

class _StockVolumeWidgetState extends State<StockVolumeWidget> with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    _animation = CurvedAnimation(parent: _animationController, curve: const Cubic(.5, .5, .5, 1));
    WidgetsBinding.instance.addPostFrameCallback((_) => _animationController.forward(from: 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) {
          return Container(
              height: ChartDimens.smxss,
              margin: widget.margin,
              child: CustomPaint(
                  size: Size.infinite,
                  painter: StockVolumePainter(stockData: widget.stockData, animation: _animation)));
        });
  }
}
