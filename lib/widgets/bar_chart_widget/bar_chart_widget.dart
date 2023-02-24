import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/bar_chart_stock_performance_model.dart';
import 'package:animated_charts/widgets/bar_chart_widget/bar_chart_painter.dart';
import 'package:flutter/material.dart';

class BarChartWidget extends StatefulWidget {
  final BarChartStockPerformanceModel? stockData;
  final EdgeInsetsGeometry margin;

  const BarChartWidget({
    Key? key,
    required this.stockData,
    this.margin = const EdgeInsets.only(right: ChartDimens.xxxs, left: ChartDimens.xxxs, top: ChartDimens.xxs),
  }) : super(key: key);

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  bool _showTooltip = false;
  Offset? _cursorPosition;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    _animation = CurvedAnimation(parent: _animationController, curve: const Cubic(.1, .3, .3, 1.5));
    WidgetsBinding.instance.addPostFrameCallback((_) => _animationController.forward(from: 0));
    super.initState();
  }

  void _onTapDown(Offset position) {
    setState(() {
      _cursorPosition = position;
      _showTooltip = true;
    });
  }

  void _removeTooltip() => setState(() => _showTooltip = false);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) {
          return Container(
              height: ChartDimens.giant,
              margin: widget.margin,
              child: GestureDetector(
                  onLongPressStart: (details) => _onTapDown(details.localPosition),
                  onLongPressUp: _removeTooltip,
                  onLongPressCancel: _removeTooltip,
                  child: CustomPaint(
                      size: Size.infinite,
                      painter: BarChartPainter(
                          stockData: widget.stockData,
                          animation: _animation,
                          showTooltip: _showTooltip,
                          cursorPosition: _cursorPosition))));
        });
  }
}
