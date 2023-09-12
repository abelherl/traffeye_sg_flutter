import 'dart:async';

import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/1_domain/failures/failures.dart';
import 'package:traffeye_sg_flutter/1_domain/usecases/traffic_camera_usecases.dart';
import 'package:traffeye_sg_flutter/2_application/core/intl/app_timeago_messages.dart';
import 'package:traffeye_sg_flutter/2_application/core/snack_bar/app_snack_bar.dart';
import 'package:traffeye_sg_flutter/2_application/core/snack_bar/app_snack_bar_data.dart';
import 'package:timeago/timeago.dart' as timeago;

class CameraController extends GetxController with StateMixin {
  final _lastUpdated = DateTime.now().obs;
  final lastUpdatedString = ''.obs;
  final cameras = <TrafficCameraEntity>[].obs;
  final savedCameras = <TrafficCameraEntity>[].obs;
  final trafficCameraUseCases = Get.find<TrafficCameraUseCases>();
  final isHideRefreshButton = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initTimeago();
    _initBox();
    _refreshLastUpdated();
  }

  void updateSnapshots({bool isHideRefreshButton = true}) async {
    _change(RxStatus.loading());

    final either = await trafficCameraUseCases.getRemoteSnapshots();

    either.fold((left) {
      _updateAllCamerasValue();
      _onFailure(left);
    }, (right) {
      _updateAllCamerasValue();

      if (isHideRefreshButton) _hideRefreshButton();

      _change(RxStatus.success());
    });
  }

  void updateCamera(
      {required TrafficCameraEntity camera, required Function() callback}) {
    final either = trafficCameraUseCases.updateCamera(camera);

    either.fold(
        (left) => _onFailure(left), (right) => _updateAllCamerasValue());

    callback();
  }

  // * Private Methods

  void _initTimeago() {
    timeago.setLocaleMessages('en', AppTimeagoMessages());

    trafficCameraUseCases.getLocalSnapshots();
  }

  void _initBox() async {
    updateSnapshots(isHideRefreshButton: false);
  }

  String _getLastUpdated() {
    final formattedString = timeago.format(
      _lastUpdated.value,
      allowFromNow: true,
    );

    lastUpdatedString.value = formattedString;

    return formattedString;
  }

  void _hideRefreshButton() {
    isHideRefreshButton.value = true;
    Future.delayed(const Duration(minutes: 1), () {
      isHideRefreshButton.value = false;
    });
  }

  void _onFailure(Failure failure) {
    _change(RxStatus.error());
    AppSnackBar.showSnackBar(AppSnackBarData.fromFailure(failure));
  }

  void _refreshLastUpdated() {
    Timer.periodic(
        const Duration(minutes: 1), (Timer t) => _updateLastUpdated());
  }

  void _updateAllCamerasValue() {
    final either1 = trafficCameraUseCases.getLocalSnapshots();

    either1.fold((left) => _onFailure(left), (right) {
      cameras.value = right;
    });

    final either2 = trafficCameraUseCases.getLocalSavedCameras();

    either2.fold((left) => _onFailure(left), (right) {
      savedCameras.value = right;
    });

    _updateLastUpdated(dateTime: cameras.firstOrNull?.timestamp);
  }

  void _updateLastUpdated({DateTime? dateTime}) {
    _lastUpdated.value = dateTime ?? _lastUpdated.value;
    lastUpdatedString.value = _getLastUpdated();
  }

  void _change(RxStatus status) => change(null, status: status);
}
