import 'dart:math';

import 'package:animated_charts/helpers/dimens.dart';
import 'package:flutter/material.dart';

class WaterPercentageMathHelper {
  final double _firstAnimationValue;
  final double _secondAnimationValue;
  final double _percentageAnimation;
  final double _borderAnimation;
  final double _percentage;
  final Size _size;

  WaterPercentageMathHelper({
    required Size size,
    required double percentageAnimation,
    required double firstAnimationValue,
    required double secondAnimationValue,
    required double borderAnimation,
    required double percentage,
  })  : _size = size,
        _percentage = percentage,
        _percentageAnimation = percentageAnimation,
        _borderAnimation = borderAnimation,
        _firstAnimationValue = firstAnimationValue,
        _secondAnimationValue = secondAnimationValue;

  double get centerX => _size.width / 2;

  double get centerY => _size.height / 2;

  double get _radius => _size.height / 2;

  double get _defaultAngle => pi / 2;

  double get _animatedWaterCirclePercentage => pi * _percentageAnimation;

  double get _animatedBorderPercentage => pi * _borderAnimation - .001;

  double get _parabolicCoefficient => centerX / 0.25;

  double get percentageValue => 100 * _percentage;

  double get borderWidth => ChartDimens.femto;

  double get borderRadius => _radius;

  double get animatedWaterStartAngle => _defaultAngle + _animatedWaterCirclePercentage;

  double get animatedBorderStartAngle => _defaultAngle + _animatedBorderPercentage;

  double get animatedWaterSweepAngle => -_animatedWaterCirclePercentage * 2;

  double get animatedBorderSweepAngle => -_animatedBorderPercentage * 2;

  Rect get animatedWaterCircleRect => Rect.fromCircle(center: Offset(centerX, centerY), radius: _radius);

  Rect get animatedBorderRect => Rect.fromCircle(center: Offset(centerX, centerY), radius: _radius);

  double get startX => centerX + cos(animatedWaterStartAngle) * _radius;

  double get startY => centerY + sin(animatedWaterStartAngle) * _radius;

  double get axisXDifference {
    double quadraticTerm = -_parabolicCoefficient * _percentageAnimation * _percentageAnimation;
    double linearTerm = _parabolicCoefficient * _percentageAnimation;

    return (quadraticTerm + linearTerm) / 20;
  }

  double get cubicXFirst => centerX - axisXDifference;

  double get cubicYFirst => _cubicAxisY * _firstAnimationValue;

  double get cubicXSecond => centerX + axisXDifference;

  double get cubicYSecond => _cubicAxisY * _secondAnimationValue;

  Rect get gradientRect {
    return Rect.fromCenter(height: _size.height, width: 0, center: Offset(_size.width / 2, _size.height / 2));
  }

  double get _cubicFactor {
    double quadraticTerm = -_percentageAnimation * _percentageAnimation * 4;
    double linearTerm = _percentageAnimation * 2.4;
    double constantTerm = 1.35;

    return quadraticTerm + linearTerm + constantTerm;
  }

  double get _cubicAxisY => _size.height / _cubicFactor;
}
