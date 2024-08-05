import 'package:flutter/widgets.dart';
import 'package:shoko_theme/shoko_theme.dart';

class ShokoThemeTextField {
  final Color enableColor;
  final Color disableColor;
  final Color focusColor;
  final Color errorColor;
  final Color cursorColor;

  final EdgeInsets insidePaddings;
  final ShokoRadii radius;

  final TextStyle? style;
  final TextStyle? labelTextStyle;
  
  final double borderWidth;
  
  final TextStyle? errorTextStyle;
  
  final bool isOutline;
  
  const ShokoThemeTextField({
    this.enableColor = const Color.fromRGBO(225, 227, 230, 1),
    this.disableColor = const Color.fromRGBO(225, 227, 230, 1),
    this.focusColor = const Color.fromRGBO(126, 127, 251, 1),
    this.errorColor = const Color.fromRGBO(255, 0, 0, 1),
    this.cursorColor = const Color.fromRGBO(126, 127, 251, 1),
    this.insidePaddings = const EdgeInsets.all(12),
    this.radius = ShokoRadii.mediumPlus,
    this.style,
    this.labelTextStyle,
    this.borderWidth = 1,
    this.errorTextStyle,
    this.isOutline = true
  });
}