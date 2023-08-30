import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/camera_details_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/assets_path_helper.dart';
import 'package:traffeye_sg_flutter/2_application/widgets/themed_text.dart';

class CameraDetailsHeader extends StatelessWidget {
  final TrafficCameraEntity camera;

  const CameraDetailsHeader({
  super.key,
  required this.camera,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CameraDetailsController>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ThemedText(
          camera.customName ?? camera.location.name,
          themedTextStyle: ThemedTextStyle.title,
          maxLines: 3,
        ),
        Obx(
          () => GestureDetector(
            onTap: () => controller.savedCameraToggle(),
            child: SizedBox(
              child: SvgPicture.asset(
                controller.isSaved.value
                    ? AssetsPathHelper.filledBookmark
                    : AssetsPathHelper.outlinedBookmark,
                colorFilter: ColorFilter.mode(
                  colorScheme.primary,
                  BlendMode.srcIn,
                ),
                width: 24.w,
                height: 24.w,
              ),
            ),
          ),
        ),
      ],
    );
  }
}