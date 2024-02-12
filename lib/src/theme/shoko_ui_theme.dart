import 'package:flutter/widgets.dart';
import 'package:shoko_ui/shoko_ui.dart';

///Widget for set ui theme
///Preferably, the entire application should be wrapped so that the theme is accessible from anywhere
class ShokoUIThemeWidget extends StatelessWidget {
  final ShokoUITheme shokoUITheme;
  final Widget child;
  const ShokoUIThemeWidget({super.key, required this.shokoUITheme, required this.child});

  @override
  Widget build(BuildContext context) {
    context.initTheme(shokoUITheme);
    return child;
  }
}

extension ShokoUIThemeExtension on BuildContext {
  static ShokoUITheme? _shokoTheme;
  initTheme(ShokoUITheme theme) => _shokoTheme = theme;

  ShokoUITheme? get shokoTheme => _shokoTheme;
}

///A class that stores global theme settings
class ShokoUITheme {
  final ShokoUIThemeButton? buttonTheme;
  final ShokoUIThemeRadio? radioTheme;
  final ShokoUIThemeTextField? textFieldTheme;
  final ShokoUIThemeSwitch? switchTheme;

  const ShokoUITheme({this.buttonTheme, this.radioTheme, this.textFieldTheme, this.switchTheme});

}

class ShokoUIThemeButton {
  final Color? color;
  final ShokoUIRadii? radius;
  final ShokoUIShadow? shadow;

  const ShokoUIThemeButton({this.color, this.radius, this.shadow});
}

class ShokoUIThemeRadio {
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? markColor;
  final ShokoUIRadii? radius;

  const ShokoUIThemeRadio({this.activeColor, this.inactiveColor, this.markColor, this.radius});
}

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

class ShokoUIThemeSwitch {
  final Color? thumbColor;
  final Color? inactiveThumbColor;
  final Color? backgroundColor;
  final Color? inactiveBackgroundColor;
  final Color? outlineColor;
  final Color? inactiveOutlineColor;

  final ShokoUISwitchType? switchType;
  
  final bool? enableOutline;
  final double? insidePadding;

  const ShokoUIThemeSwitch({
    this.thumbColor, this.inactiveThumbColor, this.backgroundColor, this.inactiveBackgroundColor, this.outlineColor, this.inactiveOutlineColor,
    this.switchType,
    this.enableOutline, this.insidePadding
  });
}
