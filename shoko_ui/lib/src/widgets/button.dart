import 'package:flutter/material.dart';
import 'package:shoko_theme/shoko_theme.dart';

enum ButtonChildPosition {
  start(MainAxisAlignment.start),
  center(MainAxisAlignment.center),
  end(MainAxisAlignment.end);
  const ButtonChildPosition(this.alignment);
  final MainAxisAlignment alignment;
}
enum ButtonWidth {
  min(MainAxisSize.min),
  max(MainAxisSize.max);
  const ButtonWidth(this.size);
  final MainAxisSize size;
}

class ShokoButton extends StatelessWidget {
  final Function()? onTap;
  final Function()? onDoubleTap;
  final Function(bool)? onHover;
  final Function()? onLongPress;

  final Color? color;

  final bool isOutline;
  final bool fullHeight;
  final bool _expanded;

  ///We recommend using it for text
  final Widget child;

  final ShokoRadii? radius;
  final ShokoShadow? shadow;
  final ButtonWidth width;
  final ButtonChildPosition childPosition;

  const ShokoButton({super.key,
    this.onTap, this.onDoubleTap, this.onHover, this.onLongPress,
    this.color, this.isOutline = false,
    required this.child,
    this.radius, this.shadow, this.fullHeight = true,
    this.width = ButtonWidth.max, this.childPosition = ButtonChildPosition.center
  }) : _expanded = false;

  
  ///Use only in rows! In columns you will recieve Overflow
  const ShokoButton.expanded({super.key,
    this.onTap, this.onDoubleTap, this.onHover, this.onLongPress,
    this.color, this.isOutline = false,
    required this.child,
    this.radius, this.shadow, this.fullHeight = true,
    this.width = ButtonWidth.max, this.childPosition = ButtonChildPosition.center
  }) : _expanded = true;


  @override
  Widget build(BuildContext context) {
    final theme = context.shokoTheme.buttonTheme;
    
    return _buildExpended(
      child: GestureDetector(
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          onLongPress: onLongPress,
          child: Container(
            height: fullHeight ? 46 : 38,
            padding: EdgeInsets.symmetric(vertical: fullHeight ? 12 : 8, horizontal: 32),
            decoration: BoxDecoration(
              color: !isOutline ? color ?? theme.color : null,
              borderRadius: (radius?.get() ?? theme.radius.get()),
              boxShadow: (shadow?.get() ?? theme.shadow?.get()),
              border: isOutline ? Border.all(
                width: 1,
                color: color ?? theme.color
              ) : null,
            ),
            child: Row(
              mainAxisSize: width.size,
              mainAxisAlignment: childPosition.alignment,
              children: [
                child
              ]
            ),
          )
      ),
    );
  }

  Widget _buildExpended({required Widget child}) {
    return _expanded ? Expanded(child: child) : child;
  }
}