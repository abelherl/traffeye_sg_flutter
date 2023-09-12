import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/camera_controller.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/explore_camera_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/assets_path_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/app_text_field.dart';
import 'package:traffeye_sg_flutter/2_application/widgets/themed_text.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final cameraController = Get.find<CameraController>();
    final exploreController = Get.find<ExploreCameraController>();

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.w,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
          SizedBox(height: 16.w),
          AppTextField(
            hint: IntlHelper.searchCameraHint.trParams(
                {'count': cameraController.cameras.length.toStringAsFixed(0)}),
            iconPath: AssetsPathHelper.filledSearch,
            textInputAction: TextInputAction.search,
            onSubmitted: (text) => exploreController.searchFor(text),
          ),
          SizedBox(height: 16.w),
          Obx(
            () => ThemedText(
              cameraController.lastUpdatedString.value,
              themedTextStyle: ThemedTextStyle.caption,
            ),
          ),
        ],
      ),
    );
  }
}
