import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/camera_details_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/style_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/app_text_field.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/negative_button.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/save_button.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/unfocuser.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/camera_details/widgets/camera_details_container.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/camera_details/widgets/camera_details_header.dart';
import 'package:traffeye_sg_flutter/theme.dart';

abstract class CameraDetailsPopUp {
  static Future openDialog({required TrafficCameraEntity camera}) async {
    await Get.dialog(
      _CameraDetailsPopUp(camera: camera),
      barrierColor: AppTheme.barrierColor,
    );
  }
}

class _CameraDetailsPopUp extends StatelessWidget {
  final TrafficCameraEntity camera;

  const _CameraDetailsPopUp({required this.camera});

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(CameraDetailsController(camera: camera.copyWith().obs));

    return Unfocuser(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: CameraDetailsContainer(
          children: [
            AspectRatio(
              aspectRatio: 328 / 190,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(camera.imageUrl),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(StyleHelper.radiusBig),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CameraDetailsHeader(camera: camera),
                  SizedBox(height: 16.w),
                  AppTextField(
                    title: IntlHelper.customName.tr,
                    hint: IntlHelper.customNameHint.tr,
                    initialText: controller.customName.value,
                    maxCharacter: 40,
                    onChanged: (text) => controller.updateCustomName(text),
                  ),
                  SizedBox(height: 32.w),
                  Row(
                    children: [
                      Expanded(
                        child: NegativeButton(
                          label: IntlHelper.close.tr,
                          onPressed: () => Get.back(),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Obx(
                          () => SaveButton(
                            isEnabled: controller.isChanged.value,
                            onPressed: () => controller.updateCamera(
                              callback: () => Get.back(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
