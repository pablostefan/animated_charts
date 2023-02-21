import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/line_chart_stock_performance_model.dart';
import 'package:animated_charts/widgets/line_chart_widget/line_chart_painter.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatefulWidget {
  final LineChartStockPerformanceModel stockData;
  final EdgeInsetsGeometry margin;
  static const double height = ChartDimens.slgiant;

  const LineChartWidget({
    Key? key,
    required this.stockData,
    this.margin = const EdgeInsets.only(right: ChartDimens.xxxs, left: ChartDimens.xxxs, top: ChartDimens.nano),
  }) : super(key: key);

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1900));
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
              height: LineChartWidget.height,
              margin: widget.margin,
              child: CustomPaint(
                  size: Size.infinite, painter: LineChartPainter(stockData: widget.stockData, animation: _animation)));
        });
  }
}
