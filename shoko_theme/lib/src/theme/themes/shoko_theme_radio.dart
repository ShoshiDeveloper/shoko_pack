import 'package:flutter/widgets.dart';
import 'package:shoko_theme/shoko_theme.dart';

class ShokoThemeRadio {
  final Color activeColor;
  final Color inactiveColor;
  final Color markColor;
  final ShokoRadii radius;

  const ShokoThemeRadio({
    this.activeColor = const Color.fromRGBO(126, 127, 251, 1),
    this.inactiveColor = const Color.fromRGBO(255, 255, 255, 1),
    this.markColor = const Color.fromRGBO(255, 255, 255, 1),
    this.radius = ShokoRadii.small
  });
}