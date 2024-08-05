import 'package:flutter/widgets.dart';
import 'package:shoko_theme/shoko_theme.dart';
import 'package:shoko_theme/src/theme/context_extension.dart';
import 'package:shoko_theme/src/theme/themes/shoko_theme_dialog.dart';
import 'package:shoko_theme/src/theme/themes/shoko_theme_mbs.dart';

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

///A class that stores global theme settings
class ShokoUITheme {
  final ShokoUIThemeButton? buttonTheme;
  final ShokoUIThemeRadio? radioTheme;
  final ShokoUIThemeTextField? textFieldTheme;
  final ShokoUIThemeSwitch? switchTheme;

  final ShokoUIDialogTheme? dialogTheme;
  final ShokoUIMBSTheme? mbsTheme;


  const ShokoUITheme({this.buttonTheme, this.radioTheme, this.textFieldTheme, this.switchTheme, this.dialogTheme, this.mbsTheme});
}







