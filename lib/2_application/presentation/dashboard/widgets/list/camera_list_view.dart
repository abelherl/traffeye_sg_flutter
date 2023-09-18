import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/camera_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/warning_widget.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/dashboard/widgets/list/camera_list_card.dart';

class CameraListView extends StatelessWidget {
  const CameraListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CameraController>();

    return controller.obx(
      (state) {
        return Obx(
          () => controller.savedCameras.isEmpty
              ? WarningWidget(
                  title: IntlHelper.errorNoSavedCamerasTitle.tr,
                  subtitle: IntlHelper.errorNoSavedCamerasSubtitle.tr,
                )
              : _ListView(),
        );
      },
      onLoading: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.white,
        child: _ListView(),
      ),
    );
  }
}

class _ListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CameraController>();
    final cameras = controller.savedCameras.isEmpty
        ? List.generate(2, (index) => TrafficCameraEntity.empty())
        : controller.savedCameras;

    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: cameras.length,
      separatorBuilder: (_, __) => SizedBox(height: 18.w),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) =>
          CameraListCard(camera: cameras[index]),
    );
  }
}
