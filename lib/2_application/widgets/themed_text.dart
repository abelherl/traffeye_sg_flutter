import 'package:flutter/material.dart';
import 'package:traffeye_sg_flutter/theme.dart';

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

  const ThemedText(
    this.text, {
    Key? key,
    this.themedTextStyle,
    this.color,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Theme(
      data: AppTheme.lightTheme,
      child: Builder(
        builder: (newContext) {
          final textTheme = Theme.of(newContext).textTheme;
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

        return Text(
            text,
            style: textStyle?.copyWith(
              color: color,
            ),
          );
        }
      ),
    );
  }
}
