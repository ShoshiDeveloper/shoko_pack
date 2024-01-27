import 'package:flutter/material.dart';
import 'package:shoko_ui/shoko_ui.dart';

enum ShokoUIRadioChildPosition {left, right}

class ShokoUIRadio extends StatelessWidget {
  final bool value;
  final Function(bool newValue)? onChange;

  final Widget? child;

  final double size;
  final Color? inactiveColor;
  final Color? activeColor;
  final Color? markColor;
  final ShokoUIRadii radius;
  final ShokoUIShadow? shadow;

  final ShokoUIRadioChildPosition childPosition;

  const ShokoUIRadio({super.key,
    required this.value, this.onChange,
    this.child,
    this.size = 32, this.inactiveColor, this.markColor, this.activeColor, this.shadow, this.radius = ShokoUIRadii.medium,
    this.childPosition = ShokoUIRadioChildPosition.right
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (childPosition == ShokoUIRadioChildPosition.left) ... [
          if(child != null) child!,
          const SizedBox(width: 8),
        ],
        InkWell(
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            if (onChange != null) onChange!(!value);
          },
          child: Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              color: value ? (activeColor ?? Colors.red) : null,
              borderRadius: radius.get(),
              border: !value ? Border.all(
                color: inactiveColor ?? (activeColor ?? Colors.red),
                width: 2
              ) : null
            ),
            child: value ? Icon(Icons.check_rounded, size: size - 4, color: markColor ?? Colors.white) : null,
          )
        ),
        if (childPosition == ShokoUIRadioChildPosition.right) ... [
          const SizedBox(width: 8),
          if(child != null) child!
        ]
      ],
    );
  }
}