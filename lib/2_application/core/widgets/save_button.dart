import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/camera_details_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/widgets/themed_text.dart';
import 'package:traffeye_sg_flutter/theme.dart';

class SaveButton extends StatelessWidget {
  final Function() onPressed;

  const SaveButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CameraDetailsController>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Obx(
      () => TextButton(
        onPressed: () => controller.isChanged.value ? onPressed() : null,
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
            controller.isChanged.value
                ? AppTheme.positiveColor
                : AppTheme.lightDisableColor,
          ),
        ),
        child: ThemedText(
          IntlHelper.save.tr,
          themedTextStyle: ThemedTextStyle.label,
          color: colorScheme.onPrimary,
        ),
      ),
    );
  }
}
