import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/camera_controller.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/map_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/camera_details/camera_details_pop_up.dart';
import 'package:traffeye_sg_flutter/theme.dart';

class ExploreCamerasPage extends StatelessWidget {
  const ExploreCamerasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cameraController = Get.find<CameraController>();
    final mapController = Get.put(MapController());

    return Scaffold(
      appBar: AppBar(
        title: Text(IntlHelper.cardCamerasTitle.tr),
        centerTitle: true,
      ),
      body: Obx(
        () => GoogleMap(
          mapToolbarEnabled: false,
          myLocationButtonEnabled: false,
          rotateGesturesEnabled: false,
          tiltGesturesEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: mapController.initialCameraPosition,
          onMapCreated: (controller) => mapController.setController(controller),
          minMaxZoomPreference: mapController.minMaxZoomPreference,
          markers: cameraController.cameras
              .map((camera) => _getMarker(camera, mapController))
              .toSet(),
        ),
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
