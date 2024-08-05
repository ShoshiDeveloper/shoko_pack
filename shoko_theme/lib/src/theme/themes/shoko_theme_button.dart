import 'package:flutter/widgets.dart';
import 'package:shoko_theme/shoko_theme.dart';

class ShokoThemeButton {
  final Color color;
  final ShokoRadii radius;
  final ShokoShadow? shadow;

  const ShokoThemeButton({
    this.color = const Color.fromRGBO(126, 127, 251, 1),
    this.radius = ShokoRadii.mediumPlus,
    this.shadow
  });
}