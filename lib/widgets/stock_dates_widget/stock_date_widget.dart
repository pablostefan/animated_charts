import 'package:animated_charts/helpers/candlestick_helpers.dart';
import 'package:animated_charts/helpers/chart_colors.dart';
import 'package:animated_charts/helpers/dimens.dart';
import 'package:flutter/material.dart';

class StockDateWidget extends StatelessWidget {
  final TimeFrame timeFrame;
  final TimeFrame? selectedTimeFrame;
  final Function(TimeFrame timeFrame) onTapTimeFrame;

  const StockDateWidget({
    Key? key,
    required this.timeFrame,
    required this.selectedTimeFrame,
    required this.onTapTimeFrame,
  }) : super(key: key);

  bool get _isSelected => timeFrame == selectedTimeFrame;

  Color get _textColor => _isSelected ? ChartColors.selectedTextColor : ChartColors.monoWhite;

  TextStyle get _textStyle => TextStyle(color: _textColor);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onTapTimeFrame(timeFrame),
        child: Padding(
            padding: const EdgeInsets.all(ChartDimens.femto), child: Text(timeFrame.displayName, style: _textStyle)));
  }
}
