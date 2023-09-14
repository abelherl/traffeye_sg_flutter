import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/camera_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/style_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/warning_widget.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/dashboard/widgets/carousel/carousel_card.dart';

class CarouselView extends StatelessWidget {
  const CarouselView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = StyleHelper.borderRadiusBig;
    final cameraController = Get.find<CameraController>();

    return cameraController.obx(
      (state) {
        return Obx(
          () => cameraController.savedCameras.isEmpty
              ? WarningWidget(
                  title: IntlHelper.errorNoSavedCamerasTitle.tr,
                  subtitle: IntlHelper.errorNoSavedCamerasSubtitle.tr,
                )
              : CarouselSlider.builder(
                  itemCount: cameraController.savedCameras.length,
                  itemBuilder: (context, index, _) {
                    final camera = cameraController.savedCameras[index];
                    return CarouselCard(camera: camera);
                  },
                  options: _carouselOptions(),
                ),
        );
      },
      onLoading: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.white,
        child: CarouselSlider.builder(
          itemCount: cameraController.savedCameras.isEmpty
              ? 1
              : cameraController.savedCameras.length,
          itemBuilder: (_, __, ___) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: Colors.white,
              ),
            );
          },
          options: _carouselOptions(),
        ),
      ),
    );
  }

  CarouselOptions _carouselOptions() {
    return CarouselOptions(
      autoPlay: false,
      enlargeCenterPage: true,
      viewportFraction: 0.8,
      aspectRatio: 328 / 164,
    );
  }
}
