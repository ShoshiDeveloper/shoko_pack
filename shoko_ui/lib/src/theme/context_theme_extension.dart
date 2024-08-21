import 'package:flutter/widgets.dart';
import 'package:shoko_ui/src/theme/theme_widget.dart';


extension SThemeExtension on BuildContext {
  static STheme _shokoTheme = const STheme();
  @protected
  initTheme(STheme theme) => _shokoTheme = theme;

  STheme get shokoTheme => _shokoTheme;
}