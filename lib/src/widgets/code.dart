import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoko_ui/shoko_ui.dart';

enum ShokoUICodeBorderType {externalOutline, underSymbolsBorder}

///Example: pin, friend code, share code and etc.
class ShokoUICode extends StatefulWidget {

  final int symbolsCount;
  final String? hintSymbol;

  final ShokoUICodeBorderType? borderType;
  final Color? errorColor;
  final Color? focusColor;
  final Color? enableColor;
  final Color? disableColor;

  final TextStyle? style;
  // keyboardType
  final TextInputType keyboardType;

  final Function(String value)? onSubmit;

  final bool isError;
  final bool isEnabled;
  ///automatically shifts the focus to the next symbol
  final bool autoNext;
  final bool fillBackground;

  final ShokoUIRadii? radius;

  const ShokoUICode({
    super.key,
    required this.symbolsCount, this.hintSymbol,
    this.borderType, this.enableColor, this.disableColor, this.errorColor, this.focusColor,
    this.style, this.keyboardType = TextInputType.number,
    this.onSubmit,
    this.isError = false, this.autoNext = true, this.fillBackground = false, this.isEnabled = true,
    this.radius
  });

  @override
  State<ShokoUICode> createState() => _ShokoUICodeState();
}

class _ShokoUICodeState extends State<ShokoUICode> {
  late final List<TextEditingController> controllers = List.generate(widget.symbolsCount, (index) => TextEditingController(text: widget.hintSymbol));
  late final List<FocusNode> focusNodes = List.generate(widget.symbolsCount, (index) => FocusNode());
  late final List<String> codeSymbols = List.generate(widget.symbolsCount, (index) => widget.hintSymbol ?? '');

  late final ShokoUICodeBorderType? borderType;
  int? focusIndex;

  @override
  void didUpdateWidget(covariant ShokoUICode oldWidget) {

    for (var i = 0; i < widget.symbolsCount; i++) {
      controllers[i].text = widget.hintSymbol ?? '';
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // borderType = widget.borderType ?? ShokoUICodeBorderType.externalOutline;
    super.initState();
  }

  @override
  void dispose() {
    controllers.map((e) => e.dispose());
    focusNodes.map((e) => e.dispose());

    super.dispose();
  }

  void symbolChanged(String symbol, int idx) {
    setState(() {
      focusIndex = null;
    });
    codeSymbols[idx] = symbol;

    if (idx == widget.symbolsCount-1) {
      FocusScope.of(context).unfocus();
      widget.onSubmit!(codeSymbols.join());
    } else if (widget.autoNext) {
      FocusScope.of(context).requestFocus(focusNodes[idx+1]);
    }
  }

  Color getWidgetSymbolColor(idx) {
    if (!widget.isEnabled) {//if code widget is disabled
      return widget.disableColor ?? Colors.grey[300]!;
    }
    //if code widget enabled and not focused
    if (focusIndex == idx) {
      return widget.focusColor ?? Colors.grey[350]!;
    }

    if (widget.isError) {
      return widget.errorColor ?? Colors.red;
    }

    return widget.enableColor ?? Colors.grey[200]!;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      decoration: widget.borderType == ShokoUICodeBorderType.externalOutline ? BoxDecoration(
        borderRadius: widget.radius?.get() ?? ShokoUIRadii.medium.get(),
        border: Border.all(
          color: widget.enableColor ?? Colors.black
        )
      ) : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          widget.symbolsCount,
          (index) => _CodeWidgetSymbol(
            controller: controllers[index],
            focusNode: focusNodes[index],
            color: getWidgetSymbolColor(index),
            keyboardType: widget.keyboardType,
            borderType: widget.borderType,
            style: widget.style,
            fillBackground: widget.fillBackground,
            radius: widget.radius,
            onTap: () {
              setState(() {
                focusIndex = index;
                controllers[index].clear();
                codeSymbols[index] = '';
              });
            },
            symbolChanged: (symbol) => symbolChanged(symbol, index),
            onTapOutside: () {
              setState(() {
                focusIndex = null;
              });
            },
          )
        )
      ),
    );
  }
}

@protected
class _CodeWidgetSymbol extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextStyle? style;
  final TextInputType keyboardType;
  final ShokoUICodeBorderType? borderType;

  final bool fillBackground;

  final Color color;
  final ShokoUIRadii? radius;

  final Function()? onTap;
  final Function(String symbol)? symbolChanged;
  final Function()? onTapOutside;
  const _CodeWidgetSymbol({
    required this.controller, required this.focusNode,
    this.style, this.borderType, required this.keyboardType,
    required this.color,
    this.onTap, this.symbolChanged, this.onTapOutside,
    required this.fillBackground, this.radius
  });

  BoxDecoration? _getDecoration() {
    if (fillBackground) {
      return BoxDecoration(
        borderRadius: radius?.get() ?? ShokoUIRadii.medium.get(),
        color: color
      );
    }
    switch (borderType) {
      case ShokoUICodeBorderType.underSymbolsBorder:
        return BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: color
            )
          ),
        );
      default:
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      // color: Colors.green,
      // height: 32+8,
      width: 36 + 8,
      // width: 64,
      decoration: _getDecoration(),
      child: Focus(
        onFocusChange: (value) {
          if (value && onTap != null) {
            onTap!();
          }
        },
        child: EditableText(
          textAlign: TextAlign.center,
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
            if(onTapOutside != null) onTapOutside!();
          },
          onChanged: symbolChanged,
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          style: style?.copyWith(fontSize: 32) ?? const TextStyle(fontSize: 32, color: Colors.black),
          cursorColor: color,
          backgroundCursorColor: color,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
          ],
        )
      )
    );
  }
}