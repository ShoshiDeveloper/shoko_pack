import 'package:flutter/widgets.dart';
import 'package:shoko_theme/shoko_theme.dart';

class ShokoUIThemeTextField {
  final Color? enableColor;
  final Color? disableColor;
  final Color? focusColor;
  final Color? errorColor;
  
  final Color? cursorColor;
  final Color? backgroundCursorColor;

  final EdgeInsets? insidePaddings;
  final ShokoUIRadii? radius;

  final TextStyle? style;
  final TextStyle? labelTextStyle;
  
  final double? borderWidth;
  
  final TextStyle? errorTextStyle;
  
  final bool? isOutline;
  
  const ShokoUIThemeTextField({
    this.enableColor, this.disableColor, this.focusColor, this.errorColor,
    this.cursorColor, this.backgroundCursorColor,
    this.insidePaddings, this.radius,
    this.style, this.labelTextStyle,
    this.borderWidth, this.errorTextStyle,
    this.isOutline
  });
}