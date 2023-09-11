import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/camera_controller.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/explore_camera_controller.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/map_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/assets_path_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/app_text_field.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/camera_details/camera_details_pop_up.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/dashboard/widgets/carousel/carousel_card.dart';
import 'package:traffeye_sg_flutter/2_application/widgets/themed_text.dart';
import 'package:traffeye_sg_flutter/theme.dart';

class ExploreCamerasPage extends StatelessWidget {
  const ExploreCamerasPage({Key? key}) : super(key: key);

  static const icons = [
    Icons.threesixty_rounded,
    Icons.add,
    Icons.account_circle_sharp
  ];

  @override
  Widget build(BuildContext context) {
    final cameraController = Get.find<CameraController>();
    final exploreController = Get.put(ExploreCameraController());
    final mapController = Get.put(MapController());

    return Scaffold(
      appBar: AppBar(
        title: Text(IntlHelper.cardCamerasTitle.tr),
        centerTitle: true,
      ),
      body: DraggableBottomSheet(
        minExtent: 110.w,
        expansionExtent: 110.w,
        useSafeArea: false,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 500),
        barrierColor: AppTheme.barrierColor,
        previewWidget: _expandedWidget(context, isPreview: true, exploreController: exploreController),
        expandedWidget: _expandedWidget(context, exploreController: exploreController),
        backgroundWidget: Obx(
          () => GoogleMap(
            mapToolbarEnabled: false,
            myLocationButtonEnabled: false,
            rotateGesturesEnabled: false,
            tiltGesturesEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: mapController.initialCameraPosition,
            onMapCreated: (controller) =>
                mapController.setController(controller),
            minMaxZoomPreference: mapController.minMaxZoomPreference,
            markers: cameraController.cameras
                .map((camera) => _getMarker(camera, mapController))
                .toSet(),
          ),
        ),
        onDragging: (_) {},
      ),
    );
  }

  Widget _expandedWidget(BuildContext context, {bool isPreview = false, ExploreCameraController? exploreController}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final cameraController = Get.find<CameraController>();
    final radius = isPreview ? 16.r : 0.0;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        ),
      ),
      child: Column(
        children: [
          Padding(
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
                  onSubmitted: (text) => exploreController!.searchFor(text),
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
          ),
          Expanded(
            child: ScrollShadow(
              size: 15,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w).copyWith(top: 0),
                physics: const BouncingScrollPhysics(),
                child: Obx(
                  () => ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: exploreController!.searchedCameras.length,
                    separatorBuilder: (_, __) => SizedBox(height: 16.w),
                    itemBuilder: (context, index) {
                      return CarouselCard(camera: exploreController.searchedCameras[index]);
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Marker _getMarker(TrafficCameraEntity camera, MapController mapController) {
    final location = camera.location;
    return Marker(
      markerId: MarkerId(camera.cameraId),
      position: LatLng(
        location.latitude,
        location.longitude,
      ),
      icon: mapController.markerIcon.value,
      onTap: () async {
        final currentZoom = await mapController.getZoomLevel();
        mapController.setMapZoomLevel(
            location: location, zoom: mapController.dialogZoomIn);
        Get.dialog(
          CameraDetailsPopUp(camera: camera),
          barrierColor: AppTheme.barrierColor,
        ).then((_) => mapController.setMapZoomLevel(
            location: location, zoom: currentZoom));
      },
    );
  }
}
