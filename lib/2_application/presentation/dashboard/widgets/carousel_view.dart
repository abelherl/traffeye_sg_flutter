import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/camera_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/assets_path_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/warning_widget.dart';
import 'package:traffeye_sg_flutter/2_application/widgets/themed_text.dart';

class CarouselView extends StatelessWidget {
  const CarouselView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16.r);
    final cameraController = Get.find<CameraController>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (cameraController.savedCameras.isEmpty) {
      return WarningWidget(
        title: IntlHelper.errorNoSavedCamerasTitle.tr,
        subtitle: IntlHelper.errorNoSavedCamerasSubtitle.tr,
      );
    }

    return cameraController.obx(
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
                      borderRadius: borderRadius,
                      image: DecorationImage(
                        image: image,
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: borderRadius,
                        gradient: const LinearGradient(
                          colors: [Colors.transparent, Colors.black54],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.5, 1],
                        ),
                      ),
                      child: Material(
                        borderRadius: borderRadius,
                        color: Colors.transparent,
                        child: Ink(
                          child: InkWell(
                            borderRadius: borderRadius,
                            splashColor:
                                colorScheme.tertiaryContainer.withOpacity(0.4),
                            highlightColor:
                                colorScheme.tertiaryContainer.withOpacity(0.4),
                            onTap: () {
                              Get.dialog(
                                BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                  child: Dialog(
                                    backgroundColor: Colors.transparent,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: colorScheme.background,
                                        borderRadius: borderRadius,
                                      ),
                                      child: Obx(
                                        () => Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            AspectRatio(
                                              aspectRatio: 328 / 190,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  image: DecorationImage(
                                                    image: image,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.vertical(
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
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      ThemedText(
                                                        camera.customName ?? camera.location.name,
                                                        themedTextStyle: ThemedTextStyle.title,
                                                      ),
                                                      IconButton(
                                                        icon: SvgPicture.asset(camera.isSaved
                                                            ? AssetsPathHelper.filledBookmark
                                                            : AssetsPathHelper.outlinedBookmark),
                                                        onPressed: () => cameraController.saveCameraToggle(camera: camera),
                                                      ),
                                                    ],
                                                  ),
                                                  ThemedText(
                                                    IntlHelper.customName.tr,
                                                    themedTextStyle: ThemedTextStyle.label,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                barrierColor:
                                    colorScheme.primary.withOpacity(0.5),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  camera.location.name,
                                  style: theme.textTheme.displayLarge?.copyWith(
                                    color: colorScheme.onPrimary,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          },
          options: _carouselOptions(),
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
