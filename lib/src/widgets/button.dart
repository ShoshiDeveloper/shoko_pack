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

  const ShokoUIButton({super.key,
    this.onTap, this.onDoubleTap, this.onHover, this.onLongPress,
    this.color, this.isOutline = false, this.isFullWidth = false, this.isChildAtCenter = false,
    required this.child, this.suffix, this.prefix,
    this.radius, this.shadow
  });

  @override
  Widget build(BuildContext context) {
    return _flexible(
      isFullWidth: isFullWidth,
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
            child: isChildAtCenter? Stack(
              // alignment: Alignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              // mainAxisAlignment: isChildAtCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
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

  Widget _flexible({required bool isFullWidth, required Widget child}) {
    return isFullWidth ? Flexible(child: child) : child;
  }
}