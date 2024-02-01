import 'package:flutter/material.dart';
import 'package:shoko_ui/shoko_ui.dart';

class ShokoUIModernTextField extends StatefulWidget {
  
  ///Be auto-dispose when widget disposed
  final TextEditingController controller;
  final TextStyle? style;

  final Function(String value)? onChange;
  final bool Function(String value)? validator;

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

  final int? minSymbols;
  final int? maxSymbols;
  
  const ShokoUIModernTextField({super.key,
    required this.controller, this.style,
    this.onChange, this.validator,
    this.isEnabled = true,
    this.isError = false, this.errorText, this.errorTextStyle,
    this.label, this.labelTextStyle,
    this.enableColor, this.disableColor, this.focusColor, this.errorColor,
    this.maxSymbols, this.minSymbols, this.obscureText = false
  });

  @override
  State<ShokoUIModernTextField> createState() => _ShokoUIModernTextFieldState();
}

class _ShokoUIModernTextFieldState extends State<ShokoUIModernTextField> {

  final FocusNode focusNode = FocusNode();
  bool isError = false;
  String value = '';

  @override
  void initState() {
    isError = widget.isError;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ShokoUIModernTextField oldWidget) {
    setState(() {
      isError = widget.isError;
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  submit(String value) {
    if(widget.onChange != null) widget.onChange!(value);
    
    bool validatorResult = true;
    if (widget.validator != null) {
      validatorResult = widget.validator!(value);
    }

    setState(() {
      isError = !validatorResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ShokoUIThemeTextField? theme = context.shokoTheme?.textFieldTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Focus(
          onFocusChange: (value) {
            !value ? submit(this.value) : setState(() {});
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
            decoration: BoxDecoration(
              borderRadius: ShokoUIRadii.mediumPlus.get(),
              border: Border.all(
                width: 1,
                color: (focusNode.hasFocus && widget.isEnabled ? (widget.focusColor ?? theme?.focusColor) : (widget.isEnabled ? (isError ? (widget.errorColor ?? theme?.errorColor) : (widget.enableColor ?? theme?.enableColor)) : (widget.disableColor ?? theme?.disableColor)) ?? Colors.black)!
              )
            ),
            child: TextField(
              onTapOutside: (event) => focusNode.unfocus(),
              onSubmitted: submit,
              onChanged: (value) => this.value = value,
              readOnly: !widget.isEnabled,
              controller: widget.controller,
              focusNode: focusNode,
              maxLength: widget.maxSymbols,
              obscureText: widget.obscureText,
              enableSuggestions: true,
              autocorrect: true,
              maxLines: 1,
              decoration: InputDecoration(
                enabled: widget.isEnabled,
                counterText: '',
                contentPadding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                label: (widget.label != null) ? Text(widget.label!) : null,
                labelStyle: (widget.labelTextStyle ?? theme?.labelTextStyle ?? TextStyle(color: focusNode.hasFocus ? widget.focusColor : (widget.isEnabled ? isError ? widget.errorColor ?? theme?.errorColor: (widget.enableColor ?? theme?.enableColor) : widget.disableColor ?? theme?.disableColor ?? Colors.grey[400]))),
                border: InputBorder.none
              ),
              style: ((widget.style ?? theme?.style) ?? const TextStyle(color: Colors.black, fontSize: 16)).copyWith(color: !widget.isEnabled ? (widget.disableColor ?? theme?.disableColor ?? Colors.grey[400]) : null),
            )
          )
        ),
        if (isError && widget.errorText != null) (Text(widget.errorText!, style: widget.errorTextStyle ?? theme?.errorTextStyle ?? TextStyle(color: widget.errorColor ?? Colors.red),))
      ]
    );
  }
}