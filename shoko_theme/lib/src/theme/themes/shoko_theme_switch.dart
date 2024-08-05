import 'package:flutter/widgets.dart';

class ShokoUIThemeSwitch {
  final Color? thumbColor;
  final Color? inactiveThumbColor;
  final Color? backgroundColor;
  final Color? inactiveBackgroundColor;
  final Color? outlineColor;
  final Color? inactiveOutlineColor;
  
  final bool? enableOutline;
  final double? insidePadding;

  final List<BoxShadow>? thumbShadow;

  const ShokoUIThemeSwitch({
    this.thumbColor, this.inactiveThumbColor, this.backgroundColor, this.inactiveBackgroundColor, this.outlineColor, this.inactiveOutlineColor,
    this.enableOutline, this.insidePadding,
    this.thumbShadow
  });
}
