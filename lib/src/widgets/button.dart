import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoko_ui/shoko_ui.dart';

class ShokoUIButton extends StatelessWidget {
  final Function()? onTap;
  final Function()? onDoubleTap;
  final Function(bool)? onHover;
  final Function()? onLongPress;

  final Color? color;

  final bool isOutline;
  final bool isChildAtCenter;
  final bool fullHeight;
  final bool _expanded;

  ///We recommend using it for text
  final Widget child;
  ///We recommend using it for the icon
  final Widget? prefix;


  final ShokoUIRadii? radius;
  final ShokoUIShadow? shadow;

  const ShokoUIButton({super.key,
    this.onTap, this.onDoubleTap, this.onHover, this.onLongPress,
    this.color, this.isOutline = false, this.isChildAtCenter = false,
    required this.child, this.prefix,
    this.radius, this.shadow, this.fullHeight = true
  }) : _expanded = false;

  
  ///Use only in rows! In columns you will recieve Overflow
  const ShokoUIButton.expanded({super.key,
    this.onTap, this.onDoubleTap, this.onHover, this.onLongPress,
    this.color, this.isOutline = false, this.isChildAtCenter = false,
    required this.child, this.prefix,
    this.radius, this.shadow, this.fullHeight = true
  }) : _expanded = true;


  @override
  Widget build(BuildContext context) {
    return _expandedWidget(
      isExpanded: _expanded,
      child: GestureDetector(
        onTap: onTap,
        onDoubleTap: onDoubleTap,
        onLongPress: onLongPress,
        child: Container(
          height: fullHeight ? 46 : 38,
          padding: EdgeInsets.symmetric(vertical: fullHeight ? 12 : 8, horizontal: 32),
          decoration: BoxDecoration(
            color: !isOutline ? color ?? (context.shokoTheme?.buttonTheme?.color ?? Colors.grey[850]) : null,
            borderRadius: (radius?.get() ?? context.shokoTheme?.buttonTheme?.radius?.get()) ?? ShokoUIRadii.medium.get(),
            boxShadow: (shadow?.get() ?? context.shokoTheme?.buttonTheme?.shadow?.get()),
            border: isOutline ? Border.all(
              width: 1,
              color: color ?? (context.shokoTheme?.buttonTheme?.color ?? Colors.grey[850]!)
            ) : null,
          ),
          child: (context.shokoTheme?.buttonTheme?.isChildAtCenter ?? isChildAtCenter) ? Stack(
          alignment: Alignment.center,
            children: [
              Row(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  if(prefix != null) ... [
                    prefix!,
                    const SizedBox(width: 8),
                  ],
                ]
              ),
              child
            ],
          ) : Row(
            children: [
              if(prefix != null) ... [
                prefix!,
                const SizedBox(width: 8),
              ],
              child
            ]
          ),
        )
      ),
    );
  }

  Widget _expandedWidget({required bool isExpanded, required Widget child}) {
    return isExpanded ? Expanded(child: child) : child;
  }
}