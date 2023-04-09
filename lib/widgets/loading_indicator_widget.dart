import 'package:animated_charts/helpers/chart_colors.dart';
import 'package:flutter/material.dart';

class ChartLoadingIndicatorWidget extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const ChartLoadingIndicatorWidget({Key? key, required this.child, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      child,
      Visibility(
          visible: isLoading,
          child: const RefreshProgressIndicator(
              backgroundColor: ChartColors.darkMonochromaticMono, color: ChartColors.selectedTextColor)),
    ]);
  }
}
