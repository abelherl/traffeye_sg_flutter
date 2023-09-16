import 'dart:async';

import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/1_domain/failures/failures.dart';
import 'package:traffeye_sg_flutter/1_domain/usecases/traffic_camera_usecases.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
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

    if (isHideRefreshButton) _hideRefreshButton();

    final either = await trafficCameraUseCases.getRemoteSnapshots();

    either.fold((left) {
      _updateAllCamerasValue();
      _hideRefreshButton(reverse: true);
      _onFailure(left);
    }, (right) {
      _updateAllCamerasValue();
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

  void updateCameras(
      {required List<TrafficCameraEntity> cameras}) {
    final either = trafficCameraUseCases.updateAllCameras(cameras);

    either.fold(
            (left) => _onFailure(left), (right) => _updateAllCamerasValue());
  }

  void updateSavedCameras(
      {required List<TrafficCameraEntity> savedCameras}) {
    final either = trafficCameraUseCases.updateSavedCameras(savedCameras);

    either.fold(
            (left) => _onFailure(left), (right) => _updateAllCamerasValue());
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

  void _hideRefreshButton({bool reverse = false}) {
    if (reverse) {
      isHideRefreshButton.value = false;
      return;
    }

    isHideRefreshButton.value = true;

    AppSnackBar.showSnackBar(
      AppSnackBarData(
        title: IntlHelper.snackBarRefreshTitle.tr,
        message: IntlHelper.snackBarRefreshSubtitle.tr,
      ),
    );

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

    for (final camera in savedCameras) {
      if (camera.sortIndex == null) {
        updateSavedCameras(savedCameras: savedCameras);
        return;
      }
    }

    savedCameras.sort((a, b) => a.sortIndex!.compareTo(b.sortIndex!));

    _updateLastUpdated(dateTime: cameras.firstOrNull?.timestamp);
  }

  void _updateLastUpdated({DateTime? dateTime}) {
    if (dateTime == _lastUpdated.value) {
      _hideRefreshButton(reverse: true);
      return;
    }

    _lastUpdated.value = dateTime ?? _lastUpdated.value;
    lastUpdatedString.value = _getLastUpdated();
  }

  void _change(RxStatus status) => change(null, status: status);
}
