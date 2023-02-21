import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/line_chart_stock_performance_model.dart';
import 'package:animated_charts/widgets/line_chart_widget/line_chart_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LineChartWidget extends StatefulWidget {
  final LineChartStockPerformanceModel stockData;
  final EdgeInsetsGeometry margin;

  const LineChartWidget({
    Key? key,
    required this.stockData,
    this.margin = const EdgeInsets.only(right: ChartDimens.xxxs, left: ChartDimens.xxxs, top: ChartDimens.xxs),
  }) : super(key: key);

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  double? _cursorPosition;
  bool _showTooltip = false;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1900));
    _animation = CurvedAnimation(parent: _animationController, curve: const Cubic(.5, .5, .5, 1));
    WidgetsBinding.instance.addPostFrameCallback((_) => _animationController.forward(from: 0));
    super.initState();
  }

  void _handleDrag(double position) {
    _lightImpact(position);
    _onChangeHandler(position);
  }

  void _lightImpact(double position) {
    bool isIndexValid = position % widget.stockData.data.length == 0;
    if (isIndexValid) HapticFeedback.lightImpact();
  }

  void _onChangeHandler(double position) {
    setState(() {
      _cursorPosition = position;
      _showTooltip = true;
    });
  }

  void _onHorizontalDragEnd(_) => setState(() => _showTooltip = false);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) {
          return GestureDetector(
              onHorizontalDragCancel: () => _onHorizontalDragEnd(_),
              onHorizontalDragDown: (details) => _handleDrag(details.localPosition.dx),
              onHorizontalDragStart: (details) => _handleDrag(details.localPosition.dx),
              onHorizontalDragUpdate: (details) => _handleDrag(details.localPosition.dx),
              onHorizontalDragEnd: _onHorizontalDragEnd,
              child: Container(
                  height: ChartDimens.slgiant,
                  margin: widget.margin,
                  child: CustomPaint(
                      size: Size.infinite,
                      painter: LineChartPainter(
                          showTooltip: _showTooltip,
                          stockData: widget.stockData,
                          animation: _animation,
                          cursorPosition: _cursorPosition))));
        });
  }
}
