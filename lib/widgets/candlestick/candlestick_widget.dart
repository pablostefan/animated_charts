import 'package:animated_charts/helpers/candlestick_helpers.dart';
import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/candlestick_stock_performance_model.dart';
import 'package:animated_charts/widgets/candlestick/candlestick_painter.dart';
import 'package:animated_charts/widgets/candlestick/stock_volume_painter.dart';
import 'package:animated_charts/widgets/loading_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CandlestickWidget extends StatefulWidget {
  final CandlestickStockPerformanceModel? stockData;
  final TimeFrame timeFrame;
  final bool isLoading;

  const CandlestickWidget({
    Key? key,
    required this.timeFrame,
    required this.isLoading,
    required this.stockData,
  }) : super(key: key);

  static const double height = ChartDimens.slgiant;

  @override
  State<CandlestickWidget> createState() => _StockCandlestickState();
}

class _StockCandlestickState extends State<CandlestickWidget> with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  double? _cursorPosition;
  bool _showTooltip = false;

  int get _stockDataLength => widget.stockData?.data.length ?? 0;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn);
    WidgetsBinding.instance.addPostFrameCallback((_) => _animationController.forward(from: 0));
    super.initState();
  }

  @override
  void didUpdateWidget(CandlestickWidget oldWidget) {
    if (oldWidget.stockData != widget.stockData) _animationController.forward(from: 0);

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleDrag(double position) {
    _lightImpact(position);
    _onChangeHandler(position);
  }

  void _lightImpact(double position) {
    bool isIndexValid = position % _stockDataLength == 0;
    if (isIndexValid) HapticFeedback.lightImpact();
  }

  void _onChangeHandler(double position) {
    setState(() {
      _cursorPosition = position;
      _showTooltip = true;
    });
  }

  void _onHorizontalDragEnd() => setState(() => _showTooltip = false);

  @override
  Widget build(BuildContext context) {
    return ChartLoadingIndicatorWidget(
        isLoading: widget.isLoading,
        child: Padding(
            padding: const EdgeInsets.all(ChartDimens.xxxs),
            child: GestureDetector(
                onHorizontalDragCancel: _onHorizontalDragEnd,
                onHorizontalDragDown: (details) => _handleDrag(details.localPosition.dx),
                onHorizontalDragStart: (details) => _handleDrag(details.localPosition.dx),
                onHorizontalDragUpdate: (details) => _handleDrag(details.localPosition.dx),
                onHorizontalDragEnd: (_) => _onHorizontalDragEnd(),
                child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (_, __) {
                      return Column(mainAxisSize: MainAxisSize.min, children: [
                        Container(
                            margin: const EdgeInsets.only(bottom: ChartDimens.femto, top: ChartDimens.micro),
                            height: CandlestickWidget.height,
                            child: CustomPaint(
                                size: Size.infinite,
                                painter: StockCandlestickPainter(
                                    stockData: widget.stockData,
                                    animation: _animation,
                                    cursorPosition: _cursorPosition,
                                    showTooltip: _showTooltip))),
                        Container(
                            height: ChartDimens.slmxss,
                            margin: const EdgeInsets.only(top: ChartDimens.xmacro),
                            child: CustomPaint(
                                size: Size.infinite,
                                painter: StockVolumePainter(
                                    stockData: widget.stockData,
                                    animation: _animation,
                                    cursorPosition: _cursorPosition,
                                    showTooltip: _showTooltip)))
                      ]);
                    }))));
  }
}
