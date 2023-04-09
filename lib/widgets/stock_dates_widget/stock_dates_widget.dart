import 'package:animated_charts/helpers/candlestick_helpers.dart';
import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/widgets/stock_dates_widget/stock_date_widget.dart';
import 'package:flutter/material.dart';

class StockDatesWidget extends StatelessWidget {
  final Function(TimeFrame timeFrame) onTapTimeFrame;
  final TimeFrame? selectedTimeFrame;

  const StockDatesWidget({
    Key? key,
    required this.onTapTimeFrame,
    required this.selectedTimeFrame,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
            top: ChartDimens.xxxs, left: ChartDimens.xxxs, right: ChartDimens.xxxs, bottom: ChartDimens.nano),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: TimeFrame.values
                .map((timeFrame) => StockDateWidget(
                    timeFrame: timeFrame, selectedTimeFrame: selectedTimeFrame, onTapTimeFrame: onTapTimeFrame))
                .toList()));
  }
}
