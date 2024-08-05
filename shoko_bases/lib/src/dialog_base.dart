import 'package:flutter/material.dart';
import 'package:shoko_theme/shoko_theme.dart';

Future<T?> showCustomDialog<T>(context, {required Widget base}) async {
  return showDialog<T>(context: context, builder: (context) => base);
}

class DialogBase extends StatelessWidget {
  final String title;
  final String content;

  final Function()? onAcceptTap;
  final String acceptButtonText;
  final Function()? onCancelTap;
  
  final Color? bgColor;
  final TextStyle? titleStyle;
  final TextStyle? contentStyle;

  final Widget actionWidget;

  const DialogBase({
    super.key,
    required this.title, required this.content,
    this.onAcceptTap, this.acceptButtonText = 'Принять', this.onCancelTap,
    this.bgColor, this.titleStyle, this.contentStyle,
    required this.actionWidget
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      surfaceTintColor: Colors.transparent,
      backgroundColor: bgColor ?? context.shokoTheme?.dialogTheme?.bgColor ?? Colors.white,
      insetPadding: const EdgeInsets.all(10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: titleStyle ?? context.shokoTheme?.dialogTheme?.titleStyle ?? const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            Text(content, style: contentStyle ?? context.shokoTheme?.dialogTheme?.contentStyle ?? const TextStyle(fontSize: 14)),
            const SizedBox(height: 16),
            actionWidget
          ],
        ),
      ),
    );
  }
}