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
  final bool isChildAtCenter;

  ///We recommend using it for text
  final Widget child;
  ///We recommend using it for the icon
  final Widget? prefix;
  ///We recommend using it for the icon
  final Widget? suffix;


  final ShokoUIRadii? radius;
  final ShokoUIShadow? shadow;

  final bool _flexible;

  ///If the button has gone off the screen, then use the flexible constructor
  const ShokoUIButton({super.key,
    this.onTap, this.onDoubleTap, this.onHover, this.onLongPress,
    this.color, this.isOutline = false, this.isFullWidth = false, this.isChildAtCenter = false,
    required this.child, this.suffix, this.prefix,
    this.radius, this.shadow
  }) : _flexible = false;

  /// Use with `isFullWidth` if this button is in `Row`
  const ShokoUIButton.flexible({super.key,
    this.onTap, this.onDoubleTap, this.onHover, this.onLongPress,
    this.color, this.isOutline = false, this.isFullWidth = false, this.isChildAtCenter = false,
    required this.child, this.suffix, this.prefix,
    this.radius, this.shadow
  }) : _flexible = true;

  @override
  Widget build(BuildContext context) {
    return _flexibleWidget(
      child: GestureDetector(
            onTap: onTap,
            onDoubleTap: onDoubleTap,
            onLongPress: onLongPress,
            child: Container(
              width: isFullWidth ? MediaQuery.of(context).size.width : null,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),//16
              decoration: BoxDecoration(
                color: !isOutline ? color ?? (context.shokoTheme?.buttonTheme?.color ?? Colors.grey[850]) : null,
                borderRadius: (radius?.get() ?? context.shokoTheme?.buttonTheme?.radius?.get()) ?? ShokoUIRadii.medium.get(),
                boxShadow: (shadow?.get() ?? context.shokoTheme?.buttonTheme?.shadow?.get()),
                border: isOutline ? Border.all(
                  width: 1,
                  color: color ?? (context.shokoTheme?.buttonTheme?.color ?? Colors.grey[850]!)
                ) : null,
              ),
              child: isChildAtCenter ? Stack(
                // alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if(prefix != null) ... [
                        prefix!,
                      ] ,
                      if(suffix != null) ... [
                    if(isFullWidth) const Expanded(child: SizedBox()),
                        suffix!
                      ]
                    ]
                  ),
                  Center(
                    child: child
                  )
                ]
              ) : Row(
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
      ),
    );
  }

  Widget _flexibleWidget({required Widget child}) {
    return _flexible ? Flexible(child: child) : child;
  }
}