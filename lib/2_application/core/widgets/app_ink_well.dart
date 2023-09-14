import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffeye_sg_flutter/theme.dart';

class AppInkWell extends StatelessWidget {
  final Widget child;
  final Function() onPressed;
  final Function()? onLongPress;
  final BorderRadius? borderRadius;
  final Color? inkColor;
  final EdgeInsets? padding;
  final Alignment? alignment;

  const AppInkWell({
    super.key,
    required this.child,
    required this.onPressed,
    this.onLongPress,
    this.borderRadius,
    this.inkColor,
    this.padding,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(16.r);
    final inkColor = this.inkColor ?? AppTheme.imagesSplashColor;
    final padding = this.padding ?? EdgeInsets.all(16.w);
    final alignment = this.alignment ?? Alignment.bottomLeft;

    return Material(
      borderRadius: borderRadius,
      color: Colors.transparent,
      child: Ink(
        child: InkWell(
          borderRadius: borderRadius,
          splashColor: inkColor,
          highlightColor: inkColor,
          onTap: onPressed,
          onLongPress: onLongPress,
          child: Padding(
            padding: padding,
            child: Align(
              alignment: alignment,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
