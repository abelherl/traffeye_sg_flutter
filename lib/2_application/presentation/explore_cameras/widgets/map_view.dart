import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/explore_camera_controller.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/map_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/unfocuser.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/camera_details/camera_details_pop_up.dart';

class MapView extends StatelessWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exploreController = Get.find<ExploreCameraController>();
    final mapController = Get.find<MapController>();

    return Obx(
      () => GoogleMap(
        mapToolbarEnabled: false,
        myLocationButtonEnabled: false,
        rotateGesturesEnabled: false,
        tiltGesturesEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: mapController.initialCameraPosition,
        onMapCreated: (controller) => mapController.setController(controller),
        onTap: (_) => Unfocuser.unfocus(),
        minMaxZoomPreference: mapController.minMaxZoomPreference,
        markers: exploreController.searchedCameras
            .map((camera) => _getMarker(camera, mapController))
            .toSet(),
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
        CameraDetailsPopUp.openDialog(camera: camera).then((_) => mapController.setMapZoomLevel(
            location: location, zoom: currentZoom));
      },
    );
  }
}
