import 'package:flutter/material.dart';

class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  const CustomThemeExtension({
    required this.progressBarColor,
    required this.percentProgressColor
  });

  final Color? progressBarColor;
  final Color? percentProgressColor;

  @override
  CustomThemeExtension copyWith({Color? brandColor, Color? danger}) {
    return CustomThemeExtension(
      progressBarColor: progressBarColor ?? progressBarColor,
      percentProgressColor: percentProgressColor ?? percentProgressColor,
    );
  }

  @override
  CustomThemeExtension lerp(CustomThemeExtension? other, double t) {
    if (other is! CustomThemeExtension) {
      return this;
    }
    return CustomThemeExtension(
      progressBarColor: Color.lerp(progressBarColor, other.progressBarColor, t),
      percentProgressColor: Color.lerp(percentProgressColor, other.percentProgressColor, t),
    );
  }
}
