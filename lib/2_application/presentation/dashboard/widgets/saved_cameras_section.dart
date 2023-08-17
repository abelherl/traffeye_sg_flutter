import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/app_controller.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/camera_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/widgets/themed_text.dart';

class SavedCamerasSection extends StatelessWidget {
  const SavedCamerasSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appController = Get.find<AppController>();
    final cameraController = Get.find<CameraController>();
    final theme = Theme.of(context);

    if (!appController.isSavedCamerasActive) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ThemedText(
                IntlHelper.savedCameras.tr,
                themedTextStyle: ThemedTextStyle.title,
              ),
              Obx(
                () => ThemedText(
                  cameraController.lastUpdated,
                  themedTextStyle: ThemedTextStyle.caption,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.w),
        cameraController.obx(
          (state) {
            return CarouselSlider.builder(
              itemCount: cameraController.savedCameras.length,
              itemBuilder: (context, index, _) {
                final camera = cameraController.savedCameras[index];
                return CachedNetworkImage(
                  imageUrl: camera.imageUrl,
                  imageBuilder: (context, image) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.w),
                        image: DecorationImage(
                          image: image,
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.w),
                          gradient: const LinearGradient(
                            colors: [Colors.transparent, Colors.black54],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.5, 1],
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Expressway North-East Gate',
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                );
              },
              options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
                aspectRatio: 328 / 180,
              ),
            );
          },
          onLoading: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.white,
            child: CarouselSlider.builder(
              itemCount: cameraController.savedCameras.isEmpty
                  ? 1
                  :cameraController.savedCameras.length,
              itemBuilder: (_, __, ___) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.w),
                    color: Colors.white,
                  ),
                );
              },
              options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
                aspectRatio: 328 / 180,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
