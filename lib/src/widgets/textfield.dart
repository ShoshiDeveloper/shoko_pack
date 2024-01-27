import 'package:flutter/material.dart';
import 'package:shoko_ui/shoko_ui.dart';

class ShokoUITextField extends StatefulWidget {
  
  ///Be auto-dispose when widget disposed
  final TextEditingController controller;
  final TextStyle? style;

  final Function(String value)? onChange;
  final bool Function(String value)? validator;

  final EdgeInsets? insidePaddings;
  final ShokoUIRadii? radius;

  final bool isEnabled;

  final bool isError;
  final String? errorText;
  final Widget? errorWidget;

  final Color? enableColor;
  final Color? disableColor;
  final Color? focusColor;
  final Color? errorColor;

  final double borderWidth;
  final double? width;

  
  const ShokoUITextField({super.key,
    required this.controller, this.style,
    this.onChange, this.validator,
    this.insidePaddings, this.radius = ShokoUIRadii.medium,
    this.isEnabled = true,
    this.isError = false, this.errorText, this.errorWidget,
    this.enableColor, this.disableColor, this.focusColor, this.errorColor,
    this.borderWidth = 2, this.width
  });

  @override
  State<ShokoUITextField> createState() => _ShokoUITextFieldState();
}

class _ShokoUITextFieldState extends State<ShokoUITextField> {

  final FocusNode focusNode = FocusNode();
  bool isError = false;
  String value = '';

  @override
  void initState() {
    isError = widget.isError;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ShokoUITextField oldWidget) {
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


    // if (!validatorResult) {
    // }
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
            width: widget.width,
            padding: widget.insidePaddings ?? const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: (widget.radius?.get() ?? context.shokoTheme?.buttonTheme?.radius?.get()),
              border: Border.all(
                width: widget.borderWidth,
                color: (focusNode.hasFocus && widget.isEnabled ? (widget.focusColor ?? theme?.focusColor) : (widget.isEnabled ? (isError ? (widget.errorColor ?? theme?.errorColor) : (widget.enableColor ?? theme?.enableColor)) : (widget.disableColor ?? theme?.disableColor))) ??Colors.grey[850]!
              )
            ),
            child: EditableText(
              onTapOutside: (event) => focusNode.unfocus(),
              onSubmitted: submit,
              // onEditingComplete: () => submit(value),
              onChanged: (value) => this.value = value,
              readOnly: !widget.isEnabled,
              controller: widget.controller,
              focusNode: focusNode,
              style: (widget.style ?? const TextStyle(color: Colors.black, fontSize: 16)).copyWith(color: !widget.isEnabled ? ((widget.disableColor ?? theme?.disableColor) ?? Colors.grey) : null),
              cursorColor: Colors.black,
              backgroundCursorColor: Colors.black
            )
          )
        ),
        if (isError && (widget.errorWidget != null || widget.errorText != null)) (widget.errorWidget ?? Text(widget.errorText!, style: TextStyle(color: widget.errorColor ?? Colors.red),))
      ]
    );
  }
}