import 'package:flutter/widgets.dart';
import 'package:shoko_theme/shoko_theme.dart';
// import 'package:shoko_theme/src/theme/context_extension.dart';
import 'package:shoko_theme/src/theme/themes/shoko_theme_dialog.dart';
import 'package:shoko_theme/src/theme/themes/shoko_theme_mbs.dart';

///Widget for set ui theme
///Preferably, the entire application should be wrapped so that the theme is accessible from anywhere
class ShokoThemeWidget extends StatelessWidget {
  final ShokoUITheme shokoUITheme;
  final Widget child;
  const ShokoThemeWidget({super.key, required this.shokoUITheme, required this.child});

  //soon
  // @protected
  // void _rebuildAllChildren(BuildContext context) {
  //   void rebuild(Element el) {
  //     el.markNeedsBuild();
  //     el.visitChildren(rebuild);
  //   }
  //   (context as Element).visitChildren(rebuild);
  // }

  @override
  Widget build(BuildContext context) {
    context.initTheme(shokoUITheme);
    return child;
  }
}

///A class that stores global theme settings
class ShokoUITheme {
  final ShokoThemeButton buttonTheme;
  final ShokoThemeRadio radioTheme;
  final ShokoThemeTextField textFieldTheme;
  final ShokoThemeSwitch switchTheme;

  final ShokoDialogTheme dialogTheme;
  final ShokoMBSTheme mbsTheme;

  const ShokoUITheme({
    this.buttonTheme = const ShokoThemeButton(),
    this.radioTheme = const ShokoThemeRadio(),
    this.textFieldTheme = const ShokoThemeTextField(),
    this.switchTheme = const ShokoThemeSwitch(),
    this.dialogTheme = const ShokoDialogTheme(),
    this.mbsTheme = const ShokoMBSTheme()
  });
}







