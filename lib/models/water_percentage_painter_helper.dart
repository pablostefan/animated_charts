import 'package:animated_charts/helpers/dimens.dart';
import 'package:animated_charts/models/water_percentage_math_helper.dart';
import 'package:flutter/material.dart';

class WaterPercentagePainterHelper {
  final double firstAnimationValue;
  final double secondAnimationValue;
  final double percentageAnimation;
  final double borderAnimation;
  final Size size;
  final double percentage;
  late final WaterPercentageMathHelper _mathHelper;
  late TextPainter _percentageTextPainter;

  WaterPercentagePainterHelper({
    required this.size,
    required this.percentageAnimation,
    required this.firstAnimationValue,
    required this.secondAnimationValue,
    required this.borderAnimation,
    required this.percentage,
  }) {
    _mathHelper = WaterPercentageMathHelper(
        size: size,
        percentage: percentage,
        percentageAnimation: percentageAnimation,
        firstAnimationValue: firstAnimationValue,
        secondAnimationValue: secondAnimationValue,
        borderAnimation: borderAnimation);
    _percentageTextPainter = _buildValuesTextPainter(_percentageText);
    _percentageTextPainter.layout(minWidth: 0, maxWidth: double.infinity);
  }

  List<Color> get _gradientColors => [Colors.lightBlueAccent, Colors.lightBlueAccent.withOpacity(.3)];

  TextPainter get percentageTextPainter => _percentageTextPainter;

  Paint get gradientPaint {
    return Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: _gradientColors,
      ).createShader(_mathHelper.gradientRect);
  }

  Paint get borderPaint {
    return Paint()
      ..color = Colors.lightBlueAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = _mathHelper.borderWidth;
  }

  Path get animatedBorderPath {
    Path path = Path()
      ..arcTo(
        _mathHelper.animatedWaterCircleRect,
        _mathHelper.animatedBorderStartAngle,
        _mathHelper.animatedBorderSweepAngle,
        true,
      );

    return path;
  }

  Path get animatedWaterPath {
    Path path = Path()
      ..arcTo(
        _mathHelper.animatedWaterCircleRect,
        _mathHelper.animatedWaterStartAngle,
        _mathHelper.animatedWaterSweepAngle,
        true,
      )
      ..cubicTo(
        _mathHelper.cubicXFirst,
        _mathHelper.cubicYFirst,
        _mathHelper.cubicXSecond,
        _mathHelper.cubicYSecond,
        _mathHelper.startX,
        _mathHelper.startY,
      );

    return path;
  }

  TextSpan _buildValuesTextSpan(String text) => TextSpan(text: text, style: _valuesTextStyle);

  TextPainter _buildValuesTextPainter(String text) {
    return TextPainter(
        strutStyle: StrutStyle.fromTextStyle(_valuesTextStyle),
        text: _buildValuesTextSpan(text),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left,
        maxLines: 1);
  }

  Offset get percentageTextOffset {
    double axisX = _mathHelper.centerX - _percentageTextPainter.width / 2;
    double axisY = _mathHelper.centerY - _percentageTextPainter.height / 2;

    return Offset(axisX, axisY);
  }

  String get _percentageText => '${_mathHelper.percentageValue}%';

  TextStyle get _valuesTextStyle {
    Color textColor = Colors.blue.withOpacity(borderAnimation);

    return TextStyle(color: textColor, fontSize: ChartDimens.xxxxmacro);
  }
}
