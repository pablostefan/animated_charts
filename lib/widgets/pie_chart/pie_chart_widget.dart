import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/pie_chart_math_helper_model.dart';
import 'package:animated_charts/models/pie_chart_model.dart';
import 'package:animated_charts/models/pie_chart_stock_performance_model.dart';
import 'package:animated_charts/widgets/pie_chart/pie_chart_painter.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatefulWidget {
  final PieChartStockPerformanceModel stockData;

  const PieChartWidget({Key? key, required this.stockData}) : super(key: key);

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1900));
    _animation = CurvedAnimation(parent: _animationController, curve: const Cubic(.5, .5, .5, 1));
    WidgetsBinding.instance.addPostFrameCallback((_) => _animationController.forward(from: 0));
    super.initState();
  }

  bool _pieChartIsSelected(PieChartModel pieChart, Offset position) {
    return pieChart.isSelected ? false : PieChartMathHelperModel.isPointInArc(position, pieChart, context);
  }

  void _setSelectedPieChart(Offset position, BuildContext context) {
    for (PieChartModel pieChart in widget.stockData.data) {
      pieChart.isSelected = _pieChartIsSelected(pieChart, position);
    }
  }

  void _onTapDown(TapDownDetails details, BuildContext context) {
    setState(() => _setSelectedPieChart(details.localPosition, context));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) {
          return Container(
              height: PieChartMathHelperModel.height,
              margin: const EdgeInsets.symmetric(vertical: ChartDimens.sm),
              child: GestureDetector(
                  onTapDown: (details) => _onTapDown(details, context),
                  child: CustomPaint(
                      size: Size.infinite,
                      painter: PieChartPainter(stockData: widget.stockData, animation: _animation))));
        });
  }
}
