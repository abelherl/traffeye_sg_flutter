import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffeye_sg_flutter/2_application/widgets/themed_text.dart';
import 'package:traffeye_sg_flutter/theme.dart';

class NegativeButton extends StatelessWidget {
  final Function() onPressed;
  final String label;

  const NegativeButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          EdgeInsets.all(12.w),
        ),
        overlayColor: MaterialStateProperty.all(
          AppTheme.negativeSplashColor,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
      child: ThemedText(
        label,
        themedTextStyle: ThemedTextStyle.label,
        color: AppTheme.negativeColor,
      ),
    );
  }
}