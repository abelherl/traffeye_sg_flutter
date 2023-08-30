import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/widgets/themed_text.dart';
import 'package:traffeye_sg_flutter/theme.dart';

class SaveButton extends StatelessWidget {
  final bool isEnabled;
  final Function() onPressed;

  const SaveButton({
    Key? key,
    required this.isEnabled,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return TextButton(
      onPressed: () => isEnabled ? onPressed() : null,
      style: ButtonStyle(
        padding: MaterialStatePropertyAll(
          EdgeInsets.all(12.w),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        backgroundColor: MaterialStatePropertyAll(
          isEnabled
              ? AppTheme.positiveColor
              : AppTheme.lightDisableColor,
        ),
      ),
      child: ThemedText(
        IntlHelper.save.tr,
        themedTextStyle: ThemedTextStyle.label,
        color: colorScheme.onPrimary,
      ),
    );
  }
}
