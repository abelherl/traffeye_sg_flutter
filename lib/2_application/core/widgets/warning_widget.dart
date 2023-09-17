import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/assets_path_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/style_helper.dart';
import 'package:traffeye_sg_flutter/2_application/widgets/themed_text.dart';

class WarningWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const WarningWidget({
    Key? key,
    required this.title,
    required this.subtitle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Get.find<ThemeData>();
    return Theme(
      data: theme,
      child: AspectRatio(
        aspectRatio: StyleHelper.ratioCarousel,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AssetsPathHelper.filledWarning),
            SizedBox(height: 12.w),
            ThemedText(
              title,
              themedTextStyle: ThemedTextStyle.title,
            ),
            SizedBox(height: 2.w),
            ThemedText(
              subtitle,
              themedTextStyle: ThemedTextStyle.caption,
              // color: theme.colorScheme.onBackground,
            ),
          ],
        ),
      ),
    );
  }
}
