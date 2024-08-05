import 'package:flutter/widgets.dart';
import 'package:shoko_theme/shoko_theme.dart';


extension ShokoUIThemeExtension on BuildContext {
  static ShokoUITheme _shokoTheme = const ShokoUITheme();
  @protected
  initTheme(ShokoUITheme theme) => _shokoTheme = theme;

  ShokoUITheme get shokoTheme => _shokoTheme;
}