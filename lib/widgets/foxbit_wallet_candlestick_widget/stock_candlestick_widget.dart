import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/stock_time_performance_model.dart';
import 'package:animated_charts/widgets/foxbit_wallet_candlestick_widget/candlestick_painter.dart';
import 'package:flutter/material.dart';

class StockCandlestickWidget extends StatefulWidget {
  final StockTimeFramePerformanceModel? stockData;

  const StockCandlestickWidget({required this.stockData, Key? key}) : super(key: key);

  static const double height = ChartDimens.slgiant;

  @override
  State<StockCandlestickWidget> createState() => _StockCandlestickState();
}

class _StockCandlestickState extends State<StockCandlestickWidget> with SingleTickerProviderStateMixin {
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
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) {
          return Container(
              margin: const EdgeInsets.only(bottom: ChartDimens.femto, top: ChartDimens.xxxmacro),
              padding: const EdgeInsets.symmetric(horizontal: ChartDimens.xxxs),
              height: StockCandlestickWidget.height,
              child: CustomPaint(
                  size: Size.infinite,
                  painter: StockCandlestickPainter(stockData: widget.stockData, animation: _animation)));
        });
  }
}
