import 'package:flutter/material.dart';
import 'package:shoko_theme/shoko_theme.dart';

class ShokoTextField extends StatefulWidget {
  
  ///Be auto-dispose when widget disposed
  final TextEditingController controller;
  final TextStyle? style;

  final Function(String value)? onChange;
  final bool Function(String value)? validator;

  final EdgeInsets? insidePaddings;
  final ShokoRadii? radius;

  final bool isEnabled;
  final bool obscureText;

  final bool isError;
  final String? errorText;
  final TextStyle? errorTextStyle;

  final String? label;
  final TextStyle? labelTextStyle;

  final Color? enableColor;
  final Color? disableColor;
  final Color? focusColor;
  final Color? errorColor;

  final double? borderWidth;

  final TextInputType? keyboardType;

  final int? minSymbols;
  final int? maxSymbols;
  
  const ShokoTextField({super.key,
    required this.controller, this.style,
    this.onChange, this.validator,
    this.insidePaddings, this.radius = ShokoRadii.medium,
    this.isEnabled = true, this.obscureText = false,
    this.isError = false, this.errorText, this.errorTextStyle,
    this.label, this.labelTextStyle,
    this.enableColor, this.disableColor, this.focusColor, this.errorColor,
    this.borderWidth,
    this.keyboardType,
    this.minSymbols, this.maxSymbols
  });

  @override
  State<ShokoTextField> createState() => _ShokoTextFieldState();
}

class _ShokoTextFieldState extends State<ShokoTextField> {

  final FocusNode focusNode = FocusNode();
  bool isError = false;
  String value = '';

  @override
  void initState() {
    isError = widget.isError;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ShokoTextField oldWidget) {
    setState(() {
      isError = widget.isError;
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // widget.controller.dispose();
    // focusNode.dispose();
    super.dispose();
  }

  submit(String value) {
    widget.onChange?.call(value);
            
    bool validatorResult = true;
    if (widget.validator != null) {
      validatorResult = widget.validator!(value);
    }


    // if (!validatorResult) {
    // }
    setState(() {
      isError = !validatorResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ShokoThemeTextField theme = context.shokoTheme.textFieldTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if(widget.label != null) Text(widget.label!, style: (widget.labelTextStyle ?? theme.labelTextStyle) ?? const TextStyle()),
        Focus(
          onFocusChange: (value) {
            !value ? submit(this.value) : setState(() {});
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
            padding: (widget.insidePaddings ?? theme.insidePaddings),
            decoration: BoxDecoration(
              borderRadius: widget.radius?.get() ?? theme.radius.get(),
              border: Border.all(
                width: (widget.borderWidth ?? theme.borderWidth),
                color: focusNode.hasFocus && widget.isEnabled ? (widget.focusColor ?? theme.focusColor) : (widget.isEnabled ? (isError ? (widget.errorColor ?? theme.errorColor) : (widget.enableColor ?? theme.enableColor)) : (widget.disableColor ?? theme.disableColor))
              )
            ),
            child: EditableText(
              keyboardType: widget.keyboardType,
              enableSuggestions: true,
              autocorrect: true,
              obscureText: widget.obscureText,
              onTapOutside: (event) => focusNode.unfocus(),
              onSubmitted: submit,
              // onEditingComplete: () => submit(value),
              onChanged: (value) => this.value = value,
              readOnly: !widget.isEnabled,
              // max: widget.maxSymbols,
              controller: widget.controller,
              focusNode: focusNode,
              style: ((widget.style ?? theme.style) ?? const TextStyle(color: Colors.black, fontSize: 16)).copyWith(color: !widget.isEnabled ? (widget.disableColor ?? theme.disableColor) : null),
              cursorColor: theme.cursorColor,
              backgroundCursorColor: Colors.transparent
            )
          )
        ),
        if (isError && widget.errorText != null) (Text(widget.errorText!, style: widget.errorTextStyle ?? theme.errorTextStyle ?? TextStyle(color: widget.errorColor ?? theme.errorColor)))
      ]
    );
  }
}