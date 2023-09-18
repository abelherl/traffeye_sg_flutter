import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/camera_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/warning_widget.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/dashboard/widgets/carousel/camera_carousel_card.dart';

class CameraCarouselView extends StatelessWidget {
  const CameraCarouselView({Key? key}) : super(key: key);

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
              : _CarouselView(),
        );
      },
      onLoading: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.white,
        child: _CarouselView(),
      ),
    );
  }
}

class _CarouselView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CameraController>();
    final cameras = controller.savedCameras.isEmpty
        ? [TrafficCameraEntity.empty()]
        : controller.savedCameras;

    return CarouselSlider.builder(
      itemCount: cameras.length,
      itemBuilder: (context, index, _) {
        final camera = cameras[index];
        return CameraCarouselCard(camera: camera);
      },
      options: CarouselOptions(
        autoPlay: false,
        enlargeCenterPage: true,
        enlargeFactor: 0.25,
        viewportFraction: 0.8,
        aspectRatio: 328 / 164,
      ),
    );
  }
}

