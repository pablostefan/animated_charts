import 'dart:async';

import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/widgets/water_percentage/water_percentage_painter.dart';
import 'package:flutter/material.dart';

class WaterPercentageWidget extends StatefulWidget {
  final double percentage;

  const WaterPercentageWidget({Key? key, required this.percentage}) : super(key: key);

  @override
  State<WaterPercentageWidget> createState() => _WaterPercentageWidgetState();
}

class _WaterPercentageWidgetState extends State<WaterPercentageWidget> with TickerProviderStateMixin {
  late final AnimationController _percentageController;
  late final AnimationController _borderController;

  late final AnimationController _firstController;
  late final Animation<double> _firstAnimation;

  late final AnimationController _secondController;
  late final Animation<double> _secondAnimation;

  Duration get _duration => const Duration(milliseconds: 1500);

  Tween<double> get _animationTween => Tween<double>(begin: 1.1, end: .6);

  @override
  void initState() {
    super.initState();
    _setControllers();
    _setAnimations();
    _forwardAnimations();
  }

  void _forwardAnimations() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(milliseconds: 600), _firstController.forward);
      Timer(const Duration(milliseconds: 1600), _secondController.forward);
      _borderController.forward();
      _percentageController.forward();
    });
  }

  void _setAnimations() {
    _firstAnimation = _animationTween.animate(CurvedAnimation(parent: _firstController, curve: Curves.easeInOut))
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) => _statusListener(status, _firstController));

    _secondAnimation = _animationTween.animate(_getCurvedAnimation(_secondController))
      ..addStatusListener((status) => _statusListener(status, _secondController));
  }

  void _setControllers() {
    _percentageController = AnimationController(vsync: this, upperBound: widget.percentage, duration: _duration);

    _borderController = AnimationController(vsync: this, duration: _duration);

    _firstController = AnimationController(vsync: this, duration: _duration);

    _secondController = AnimationController(vsync: this, duration: _duration);
  }

  CurvedAnimation _getCurvedAnimation(AnimationController controller) {
    return CurvedAnimation(parent: controller, curve: Curves.easeInOut);
  }

  void _statusListener(AnimationStatus status, AnimationController controller) {
    if (status == AnimationStatus.completed) {
      controller.reverse();
    } else if (status == AnimationStatus.dismissed) {
      controller.forward();
    }
  }

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _percentageController,
        builder: (_, __) {
          return Container(
              height: ChartDimens.xlls,
              margin: const EdgeInsets.symmetric(vertical: ChartDimens.xxs),
              child: CustomPaint(
                  size: Size.infinite,
                  painter: WaterPercentagePainter(
                      percentage: widget.percentage,
                      percentageAnimation: _percentageController.value,
                      firstAnimationValue: _firstAnimation.value,
                      secondAnimationValue: _secondAnimation.value,
                      borderAnimation: _borderController.value)));
        });
  }
}
