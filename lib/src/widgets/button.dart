import 'package:flutter/material.dart';
import 'package:shoko_ui/shoko_ui.dart';

class ShokoUIButton extends StatelessWidget {
  final Function()? onTap;
  final Function()? onDoubleTap;
  final Function(bool)? onHover;
  final Function()? onLongPress;

  final Color? color;

  final bool isOutline;
  final bool isFullWidth;

  ///We recommend using it for text
  final Widget child;
  ///We recommend using it for the icon
  final Widget? prefix;
  ///We recommend using it for the icon
  final Widget? suffix;


  final ShokoUIRadii radius;
  final ShokoUIShadow? shadow;

  const ShokoUIButton({super.key,
    this.onTap, this.onDoubleTap, this.onHover, this.onLongPress,
    this.color, this.isOutline = false, this.isFullWidth = false,
    required this.child, this.suffix, this.prefix,
    this.radius = ShokoUIRadii.medium, this.shadow
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onHover: onHover,
      onLongPress: onLongPress,
      child: Ink(
        width: isFullWidth ? double.maxFinite : null,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: color ?? Colors.grey[850],
          borderRadius: radius.get(),
          boxShadow: shadow?.get(),
          border: isOutline ? Border.all(
            width: 1,
            color: color ?? Colors.grey[850]!
          ) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(prefix != null) ... [
              prefix!,
              const SizedBox(width: 8),
            ] ,
            child,
            if(suffix != null) ... [
              if(isFullWidth) const Expanded(child: SizedBox()),
              const SizedBox(width: 8),
              suffix!
            ]
          ]
        ),
      ),
    );
  }
}