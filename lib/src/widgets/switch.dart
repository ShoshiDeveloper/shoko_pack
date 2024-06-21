import 'package:flutter/material.dart';
import 'package:shoko_ui/shoko_ui.dart';

enum ShokoUISwitchType {long, short}

extension ShokoUISwitchTypeExtension on ShokoUISwitchType {
  double getHeight(double width) {
    switch (name) {
      case "long":
        return width/2;
      case "short":
        return width/1.6;
      default:
        return width/2;
    }
  }
    double getMargin(double width) {
    switch (name) {
      case "long":
        return width/2;
      case "short":
        return width/2.5;
      default:
        return width/2;
    }
  }
}

class ShokoUISwitch extends StatefulWidget {
  final Function(bool newValue)? onChange;
  
  final bool value;
  final double width;

  final Color? thumbColor;
  final Color? inactiveThumbColor;
  final Color? backgroundColor;
  final Color? inactiveBackgroundColor;
  final Color? outlineColor;
  final Color? inactiveOutlineColor;
  
  final ShokoUISwitchType? switchType;

  final bool? enableOutline;
  final double? insidePadding;

  final List<BoxShadow>? thumbShadow;

  const ShokoUISwitch({super.key,
    required this.value, this.onChange, this.width = 64,
    this.thumbColor, this.backgroundColor, this.outlineColor, this.inactiveThumbColor, this.inactiveBackgroundColor, this.inactiveOutlineColor,
    this.switchType,
    this.enableOutline, this.insidePadding, this.thumbShadow
  });

  @override
  State<ShokoUISwitch> createState() => _ShokoUISwitchState();
}

class _ShokoUISwitchState extends State<ShokoUISwitch> {
  late bool value;

  late Color thumbColor;
  late Color backgroundColor;
  late Color outlineColor;

  late ShokoUIThemeSwitch? theme;

  setColors() {
    // thumbColor = (value ? (widget.thumbColor ?? Colors.red) : (widget.inactiveThumbColor ?? Colors.red));
    thumbColor = (value ? ((widget.thumbColor ?? theme?.thumbColor) ?? Colors.red) : ((widget.inactiveThumbColor ?? theme?.inactiveThumbColor) ?? (widget.thumbColor ?? theme?.thumbColor)) ?? Colors.red);
    backgroundColor = (value ? ((widget.backgroundColor ?? theme?.backgroundColor) ?? Colors.grey[850]) : ((widget.inactiveBackgroundColor ?? theme?.inactiveBackgroundColor) ?? (widget.backgroundColor ?? theme?.backgroundColor)) ?? Colors.grey[850])!;
    outlineColor = (value ? ((widget.outlineColor ?? theme?.outlineColor) ?? Colors.grey[850]) : ((widget.inactiveOutlineColor ?? theme?.inactiveOutlineColor) ?? (widget.outlineColor ?? theme?.outlineColor)) ?? Colors.grey[850])!;
    // outlineColor = (value ? (widget.outlineColor ?? Colors.grey[850]) : (widget.inactiveOutlineColor ?? Colors.grey[850]))!;
  }

  @override
  void didUpdateWidget(covariant ShokoUISwitch oldWidget) {
    theme = context.shokoTheme?.switchTheme;
    setState(() {
      value = widget.value;
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    theme = context.shokoTheme?.switchTheme;
    value = widget.value;
    setColors();
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    setColors();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        if(widget.onChange != null) widget.onChange!(!value);
      },
      child: Container(
        width: widget.width,
        height: (widget.switchType ?? context.shokoTheme?.switchTheme?.switchType ?? ShokoUISwitchType.long).getHeight(widget.width),
        padding: EdgeInsets.all((widget.insidePadding ?? theme?.insidePadding) ?? 4),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100),
          border: ((widget.enableOutline ?? theme?.enableOutline) ?? false) ? Border.all(
            width: 2,
            color: outlineColor
          ) : null
        ),
        child: AnimatedContainer(
          margin: EdgeInsets.only(
            left: value ? (widget.switchType ?? context.shokoTheme?.switchTheme?.switchType ?? ShokoUISwitchType.long).getMargin(widget.width) : 0,
            right: value ? 0 : (widget.switchType ?? context.shokoTheme?.switchTheme?.switchType ?? ShokoUISwitchType.long).getMargin(widget.width)
          ),
          decoration: BoxDecoration(
            color: thumbColor,
            boxShadow: widget.thumbShadow ?? context.shokoTheme?.switchTheme?.thumbShadow,
            borderRadius: BorderRadius.circular(100)
          ),
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInSine,
          )
      )
    );
  }
}