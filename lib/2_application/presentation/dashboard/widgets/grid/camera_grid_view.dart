import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/camera_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/style_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/warning_widget.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/dashboard/widgets/grid/camera_grid_card.dart';

class CameraGridView extends StatelessWidget {
  const CameraGridView({super.key});

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
              : _GridView(),
        );
      },
      onLoading: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.white,
        child: _GridView(),
      ),
    );
  }
}

class _GridView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CameraController>();
    final cameras = controller.savedCameras.isEmpty
        ? List.generate(4, (index) => TrafficCameraEntity.empty())
        : controller.savedCameras;

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 18.w,
        crossAxisSpacing: 18.w,
        childAspectRatio: StyleHelper.ratioGrid,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: cameras.length,
      itemBuilder: (_, index) =>
          CameraGridCard(camera: cameras[index]),
    );
  }
}
