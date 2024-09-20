import 'package:flutter/material.dart';
import 'package:shoko_ui/src/theme/extensions/context_theme_extension.dart';
import 'package:shoko_ui/src/widgets/switch/shoko_theme_switch.dart';

enum ShokoSwitchType {long, short}

class ShokoSwitch extends StatefulWidget {
  final Function(bool newValue)? onChange;
  
  final bool value;
  final double width;

  final Color? thumbColor;
  final Color? inactiveThumbColor;
  final Color? backgroundColor;
  final Color? inactiveBackgroundColor;
  final Color? outlineColor;
  final Color? inactiveOutlineColor;
  
  final ShokoSwitchType switchType;

  final List<BoxShadow>? thumbShadow;

  final bool? enableOutline;
  final double? insidePadding;

  const ShokoSwitch({super.key,
    required this.value, this.onChange, this.width = 64,
    this.thumbColor, this.backgroundColor, this.outlineColor, this.inactiveThumbColor, this.inactiveBackgroundColor, this.inactiveOutlineColor,
    this.switchType = ShokoSwitchType.short,
    this.enableOutline, this.insidePadding,
    this.thumbShadow
  });

  @override
  State<ShokoSwitch> createState() => _ShokoSwitchState();
}

class _ShokoSwitchState extends State<ShokoSwitch> {
  late bool value;

  late Color thumbColor;
  late Color backgroundColor;
  late Color outlineColor;

  late SSwitchTheme theme;

  final double divider = 1.6;
  double get difference => widget.width - (widget.width / divider);

  setColors() {
    thumbColor = (value ? ((widget.thumbColor ?? theme.thumbColor)) : ((widget.inactiveThumbColor ?? theme.inactiveThumbColor)));
    backgroundColor = (value ? ((widget.backgroundColor ?? theme.backgroundColor)) : ((widget.inactiveBackgroundColor ?? theme.inactiveBackgroundColor)));
    outlineColor = (value ? ((widget.outlineColor ?? theme.outlineColor)) : ((widget.inactiveOutlineColor ?? theme.inactiveOutlineColor)));
  }

  @override
  void didUpdateWidget(covariant ShokoSwitch oldWidget) {
    theme = context.theme.switchTheme;
    setState(() {
      value = widget.value;
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    theme = context.theme.switchTheme;
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
      onTap: () => widget.onChange?.call(!value),
      child: Container(
        width: widget.width,
        height: widget.width / divider,
        padding: EdgeInsets.all(widget.insidePadding ?? theme.insidePadding),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(widget.width),
          border: (widget.enableOutline ?? theme.enableOutline) ? Border.all(
            width: 2,
            color: outlineColor
          ) : null
        ),
        child: AnimatedContainer(
          margin: EdgeInsets.only(
            left: value ? difference : 0,
            right: value ? 0 : difference
          ),
          decoration: BoxDecoration(
            color: thumbColor,
            boxShadow: widget.thumbShadow ?? context.theme.switchTheme.thumbShadow,
            borderRadius: BorderRadius.circular(widget.width)
          ),
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInSine,
          )
      )
    );
  }
}