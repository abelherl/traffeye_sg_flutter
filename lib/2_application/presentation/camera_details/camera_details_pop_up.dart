import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/negative_button.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/save_button.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/camera_details/widgets/camera_details_header.dart';
import 'package:traffeye_sg_flutter/2_application/widgets/themed_text.dart';


class CameraDetailsPopUp extends StatelessWidget {
  final TrafficCameraEntity camera;

  const CameraDetailsPopUp({
    Key? key,
    required this.camera,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final borderRadius = BorderRadius.circular(16.r);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.background,
            borderRadius: borderRadius,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AspectRatio(
                aspectRatio: 328 / 190,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(camera.imageUrl),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r),
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
                    ThemedText(
                      IntlHelper.customName.tr,
                      themedTextStyle: ThemedTextStyle.label,
                    ),
                    const TextField(),
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
                          child: SaveButton(
                            onPressed: () => Get.back(),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
