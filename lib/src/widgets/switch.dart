import 'package:flutter/material.dart';
import 'package:shoko_ui/shoko_ui.dart';

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

  final bool enableOutline;
  final double insidePadding;

  const ShokoUISwitch({super.key,
    required this.value, this.onChange, this.width = 64,
    this.thumbColor, this.backgroundColor, this.outlineColor, this.inactiveThumbColor, this.inactiveBackgroundColor, this.inactiveOutlineColor,
    this.enableOutline = false, this.insidePadding = 4
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
        height: widget.width/2,
        padding: EdgeInsets.all(widget.insidePadding),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100),
          border: !(widget.enableOutline) ? null : Border.all(
            width: 2,
            color: outlineColor
          )
        ),
        child: AnimatedContainer(
          margin: EdgeInsets.only(left: value ? widget.width/2 : 0, right: value ? 0 : widget.width/2),
          decoration: BoxDecoration(
            color: thumbColor,
            borderRadius: BorderRadius.circular(100)
          ),
          // height: 32,
          // width: 32,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInSine,
          )
      )
    );
  }
}