import 'dart:ui' as ui;

import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/location_entity.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/assets_path_helper.dart';

class MapController extends GetxController {
  final _mapStyle = ''.obs;
  late final GoogleMapController _mapController;
  final markerIcon = BitmapDescriptor.defaultMarker.obs;
  final minZoom = 11.5;
  final maxZoom = 18.0;
  final dialogZoomIn = 15.0;
  late final minMaxZoomPreference =
      MinMaxZoomPreference(minZoom, maxZoom);
  late final initialCameraPosition = CameraPosition(
    target: const LatLng(1.290270, 103.851959),
    zoom: minZoom,
  );

  @override
  void onInit() {
    super.onInit();

    _setMapStyle();
    _setMarkerStyle();
  }

  Future<double> getZoomLevel() async {
    return await _mapController.getZoomLevel();
  }

  void setController(GoogleMapController controller) {
    _mapController = controller;
    _mapController.setMapStyle(_mapStyle.value);
  }

  void setMapZoomLevel(
      {required LocationEntity location, required double zoom}) {
    final latLng = LatLng(location.latitude, location.longitude);
    _mapController.animateCamera(CameraUpdate.newLatLngZoom(latLng, zoom));
  }

  // * Private Methods

  void _setMapStyle() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      rootBundle.loadString(AssetsPathHelper.styleMap).then((style) {
        _mapStyle.value = style;
      });
    });
  }

  void _setMarkerStyle() async {
    final data = await rootBundle.load(AssetsPathHelper.imagesMarker);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: 200);
    final frameInfo = await codec.getNextFrame();
    final icon =
        await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
    final iconBytes = icon!.buffer.asUint8List();

    markerIcon.value = BitmapDescriptor.fromBytes(iconBytes);
  }
}
