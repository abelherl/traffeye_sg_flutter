import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_rich_text/simple_rich_text.dart';

enum ThemedTextStyle {
  display,
  title,
  label,
  body,
  caption,
}

class ThemedText extends StatelessWidget {
  final String text;
  final ThemedTextStyle? themedTextStyle;
  final Color? color;
  final TextStyle? textStyle;
  final int? maxLines;

  const ThemedText(
    this.text, {
    Key? key,
    this.themedTextStyle,
    this.color,
    this.textStyle,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Get.find<ThemeData>(),
      child: Builder(builder: (newContext) {
        final theme = Theme.of(newContext);
        final textTheme = theme.textTheme;
        TextStyle? textStyle;

        if (themedTextStyle != null) {
          switch (themedTextStyle!) {
            case ThemedTextStyle.display:
              textStyle = textTheme.displayLarge!;
            case ThemedTextStyle.title:
              textStyle = textTheme.titleLarge!;
            case ThemedTextStyle.label:
              textStyle = textTheme.labelLarge!;
            case ThemedTextStyle.caption:
              textStyle = textTheme.labelSmall!;
            case ThemedTextStyle.body:
              textStyle = textTheme.bodyLarge!;
          }
        } else {
          textStyle = textStyle;
        }
        return SimpleRichText(
          text,
          style: textStyle?.copyWith(
            color: color ?? theme.colorScheme.onBackground,
          ),
          maxLines: maxLines,
        );
      }),
    );
  }
}
