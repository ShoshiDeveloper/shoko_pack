import 'package:flutter/material.dart';
import 'package:shoko_theme/shoko_theme.dart';

Future<T?> showMBS<T>(context, {required Widget base, bool isScrollControlled = true}) async {
  return showModalBottomSheet<T>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: isScrollControlled,
    useSafeArea: true,
    builder: (context) => base,
  );
}

@immutable
class MBSBase extends StatelessWidget {
  final String? label;
  final Widget? content;
  final Widget? bottom;

  final double? height;
  final bool labelOnCenter;

  ///Не забудь включить scrolling в showModalBottomSheet
  final bool kIsFullHeight;

  final Color? bgColor;
  final Color? indicatorColor;
  final TextStyle? titleStyle;

  final Function()? userAccept;
  final Function()? onCancel;

  const MBSBase({
    super.key,
    this.label,
    this.content,
    this.height,
    this.onCancel,
    this.labelOnCenter = true,
    this.kIsFullHeight = false,
    this.bottom,
    this.bgColor,
    this.indicatorColor,
    this.titleStyle
  })  : userAccept = null;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          height: height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 16 + MediaQuery.of(context).viewInsets.bottom, top: 16),
          decoration: BoxDecoration(color: bgColor ?? context.shokoTheme?.mbsTheme?.bgColor ?? Colors.white, borderRadius: const BorderRadius.all(Radius.circular(16))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: kIsFullHeight ? MainAxisSize.max : MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  height: 5,
                  width: 50,
                  margin: const EdgeInsets.symmetric(vertical: 7.5),
                  decoration: BoxDecoration(
                    color: indicatorColor ?? context.shokoTheme?.mbsTheme?.indicatorColor ?? Colors.grey,
                    borderRadius: BorderRadius.circular(50)
                  ),
                )
              ),
              const SizedBox(height: 5),
              if (label != null)
                Column(
                  crossAxisAlignment: labelOnCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  children: [
                    Text(label!, style: titleStyle ?? context.shokoTheme?.mbsTheme?.titleStyle ?? const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 16)
                  ]
                ),
              if (content != null) content!,
              if (bottom != null) ... [
                const SizedBox(height: 32),
                if (bottom != null) bottom!,
              ],
              const SizedBox(height: 16),
            ],
          ),
        ),
    );
  }
}