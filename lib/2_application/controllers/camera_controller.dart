import 'dart:async';

import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/location_entity.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/1_domain/failures/failures.dart';
import 'package:traffeye_sg_flutter/1_domain/usecases/traffic_camera_usecases.dart';
import 'package:traffeye_sg_flutter/2_application/core/intl/app_timeago_messages.dart';
import 'package:traffeye_sg_flutter/2_application/core/snack_bar/app_snack_bar.dart';
import 'package:traffeye_sg_flutter/2_application/core/snack_bar/app_snack_bar_data.dart';
import 'package:timeago/timeago.dart' as timeago;

class CameraController extends GetxController with StateMixin {
  final _lastUpdated = DateTime.now().obs;
  final lastUpdatedString = 'Unknown last updated'.obs;
  final cameras = <TrafficCameraEntity>[].obs;
  final savedCameras = [
    TrafficCameraEntity(
      cameraId: '1001',
      timestamp: DateTime.now(),
      imageUrl: 'imageUrl',
      location: LocationEntity(latitude: 1, longitude: 1),
    ),
    TrafficCameraEntity(
      cameraId: '1002',
      timestamp: DateTime.now(),
      imageUrl: 'imageUrl',
      location: LocationEntity(latitude: 1, longitude: 1),
    ),
    TrafficCameraEntity(
      cameraId: '1003',
      timestamp: DateTime.now(),
      imageUrl: 'imageUrl',
      location: LocationEntity(latitude: 1, longitude: 1),
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    _initTimeago();
    updateSnapshots();
    _refreshLastUpdated();
  }

  void _initTimeago() {
    timeago.setLocaleMessages('en', AppTimeagoMessages());
  }

  void updateSnapshots() async {
    _change(RxStatus.loading());

    if (cameras.isNotEmpty) {
      _lastUpdated.value = cameras.firstOrNull!.timestamp;
      lastUpdatedString.value = _getLastUpdated();
    }

    final either = await Get.find<TrafficCameraUseCases>().getSnapshots();

    either.fold((left) => _onFailure(left), (right) {
      _lastUpdated.value = DateTime.now();
      lastUpdatedString.value = _getLastUpdated();
      cameras.value = right;

      final camerasSet = cameras.toSet();
      final savedCamerasSet = savedCameras.toSet();

      savedCameras.value = camerasSet.intersection(savedCamerasSet).toList();

      _change(RxStatus.success());
    });
  }

  void _onFailure(Failure failure) {
    _change(RxStatus.error());
    AppSnackBar.showSnackBar(AppSnackBarData.fromFailure(failure));
  }

  String _getLastUpdated() {
    if (savedCameras.isEmpty) return 'Unknown last updated';

    final formattedString = timeago.format(
      _lastUpdated.value,
      allowFromNow: true,
    );

    lastUpdatedString.value = formattedString;

    return formattedString;
  }

  void _refreshLastUpdated() {
    Timer.periodic(const Duration(minutes: 1),
        (Timer t) => lastUpdatedString.value = _getLastUpdated());
  }

  void _change(RxStatus status) => change(null, status: status);
}
