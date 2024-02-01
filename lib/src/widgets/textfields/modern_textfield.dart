import 'package:flutter/material.dart';
import 'package:shoko_ui/shoko_ui.dart';

class ShokoUIModernTextField extends StatefulWidget {
  
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

  final String? label;
  final TextStyle? labelTextStyle;

  final Color? enableColor;
  final Color? disableColor;
  final Color? focusColor;
  final Color? errorColor;

  final double? borderWidth;
  final double? width;

  
  const ShokoUIModernTextField({super.key,
    required this.controller, this.style,
    this.onChange, this.validator,
    this.insidePaddings, this.radius = ShokoUIRadii.medium,
    this.isEnabled = true,
    this.isError = false, this.errorText, this.errorWidget,
    this.label, this.labelTextStyle,
    this.enableColor, this.disableColor, this.focusColor, this.errorColor,
    this.borderWidth, this.width
  });

  @override
  State<ShokoUIModernTextField> createState() => _ShokoUIModernTextFieldState();
}

class _ShokoUIModernTextFieldState extends State<ShokoUIModernTextField> {

  final FocusNode focusNode = FocusNode();
  bool isError = false;
  bool isEmpty = true;
  bool loading = false;
  String value = '';


  double height = 48;

  double calcHeight() {
    double paddingsSum = 24;
    double height = 16;

    if (widget.insidePaddings != null) {
      paddingsSum += widget.insidePaddings!.top + widget.insidePaddings!.bottom;
    } else if (context.shokoTheme?.textFieldTheme?.insidePaddings != null) {
      paddingsSum += context.shokoTheme!.textFieldTheme!.insidePaddings!.top + context.shokoTheme!.textFieldTheme!.insidePaddings!.bottom;
    }

    return paddingsSum + height;
  }

  @override
  void initState() {
    isError = widget.isError;
    isEmpty = widget.controller.text.isEmpty;

    height = calcHeight();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ShokoUIModernTextField oldWidget) {
    setState(() {
      isError = widget.isError;
      isEmpty = widget.controller.text.isEmpty;
      height = calcHeight();
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

    return GestureDetector(
      onTap: () {
        if (widget.controller.text.isEmpty) {
        print("tap");
          setState(() {
            isEmpty = false;
            loading = true;
            focusNode.requestFocus();
          });
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Focus(
            onFocusChange: (value) {
              if (!value && widget.controller.text.isEmpty) {
                setState(() {
                  isEmpty = true;
                  loading = true;
                });
              }
              !value ? submit(this.value) : setState(() {});
            },
            child: AnimatedContainer(
              height: height,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
              width: (widget.width ?? theme?.width),
              padding: (widget.insidePaddings ?? theme?.insidePaddings) ?? const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: (widget.radius?.get() ?? theme?.radius?.get()) ?? ShokoUIRadii.medium.get(),
                border: Border.all(
                  width: (widget.borderWidth ?? theme?.borderWidth) ?? 2,
                  color: (focusNode.hasFocus && widget.isEnabled ? (widget.focusColor ?? theme?.focusColor) : (widget.isEnabled ? (isError ? (widget.errorColor ?? theme?.errorColor) : (widget.enableColor ?? theme?.enableColor)) : (widget.disableColor ?? theme?.disableColor))) ??Colors.grey[850]!
                )
              ),
              child: Column(
                children: [
                  Expanded(
                    child: AnimatedAlign(
                      alignment: isEmpty ? Alignment.centerLeft : Alignment.topLeft,
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        color: Colors.grey[400],
                        child: AnimatedDefaultTextStyle(
                          onEnd: () {
                            setState(() {
                              loading = false;
                            });
                          },
                          child: Text('Header'),
                          style: TextStyle(fontSize: isEmpty ? 24 : 12, color: Colors.black),
                          duration: const Duration(milliseconds: 500),
                          curve: isEmpty ? Curves.easeIn : Curves.easeOut,
                        )
                      ),
                    )
                  ),
                  // if(loading) const Expanded(child: SizedBox()),
                  if(!isEmpty && !loading) EditableText(
                    onTapOutside: (event) => focusNode.unfocus(),
                    onSubmitted: submit,
                    onChanged: (value) => this.value = value,
                    readOnly: !widget.isEnabled,
                    controller: widget.controller,
                    focusNode: focusNode,
                    style: ((widget.style ?? theme?.style) ?? const TextStyle(color: Colors.black, fontSize: 16)).copyWith(color: !widget.isEnabled ? ((widget.disableColor ?? theme?.disableColor) ?? Colors.grey) : null),
                    cursorColor: Colors.black,
                    backgroundCursorColor: Colors.black
                  )
                ],
              )
            )
          ),
          // if (isError && (widget.errorWidget != null || widget.errorText != null)) (widget.errorWidget ?? Text(widget.errorText!, style: TextStyle(color: widget.errorColor ?? Colors.red),))
        ]
      )
    );
  }
}