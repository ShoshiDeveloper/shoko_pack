import 'package:flutter/widgets.dart';
import 'package:shoko_ui/src/theme/widget/theme_widget.dart';


extension SThemeExtension on BuildContext {
  @protected
  static STheme _currentTheme = const STheme();
  @protected
  static bool _isThemeInitialized = false;

  STheme get theme => _currentTheme;

  @protected
  void initTheme(STheme theme) {
    if(!_isThemeInitialized) {
      _currentTheme = theme;
      _isThemeInitialized = true;
    }
  }

  void changeTheme(STheme theme) {
    _currentTheme = theme;    
    
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }
    
    (this as Element).markNeedsBuild();
    (this as Element).visitChildren(rebuild);
  }
}