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

  String get lastUpdated {
    if (savedCameras.isEmpty) return '';
    return timeago.format(
      _lastUpdated.value,
      allowFromNow: true,
    );
  }

  @override
  void onInit() {
    super.onInit();
    _initTimeago();
    updateSnapshots();
  }

  void _initTimeago() {
    timeago.setLocaleMessages('en', AppTimeagoMessages());
  }

  void updateSnapshots() async {
    _change(RxStatus.loading());

    final either = await Get.find<TrafficCameraUseCases>().getSnapshots();

    either.fold((left) => onFailure(left), (right) {
      _lastUpdated.value = DateTime.now();
      cameras.value = right;

      final camerasSet = cameras.toSet();
      final savedCamerasSet = savedCameras.toSet();

      savedCameras.value = camerasSet.intersection(savedCamerasSet).toList();
      _change(RxStatus.success());
    });
  }

  void onFailure(Failure failure) {
    _change(RxStatus.error());
    AppSnackBar.showSnackBar(AppSnackBarData.fromFailure(failure));
  }

  void _change(RxStatus status) => change(null, status: status);
}
