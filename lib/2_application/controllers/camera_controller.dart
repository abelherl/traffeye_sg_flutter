import 'dart:async';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/1_domain/failures/failures.dart';
import 'package:traffeye_sg_flutter/1_domain/usecases/traffic_camera_usecases.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/box_tags_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/intl/app_timeago_messages.dart';
import 'package:traffeye_sg_flutter/2_application/core/snack_bar/app_snack_bar.dart';
import 'package:traffeye_sg_flutter/2_application/core/snack_bar/app_snack_bar_data.dart';
import 'package:timeago/timeago.dart' as timeago;

class CameraController extends GetxController with StateMixin {
  final _lastUpdated = DateTime.now().obs;
  final lastUpdatedString = 'Unknown last updated'.obs;
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
      _getLocalCameras();
      _onFailure(left);
    }, (right) {
      trafficCameraUseCases.updateAllCameras(right);
      _updateAllCamerasValue(right);
      _updateLastUpdated(dateTime: DateTime.now());

      if (isHideRefreshButton) _hideRefreshButton();

      _change(RxStatus.success());
    });
  }

  void saveCameraToggle({required TrafficCameraEntity camera, required Function() callback}) {
    final index = cameras.indexWhere((element) => element == camera);
    if (index != -1) {
      // trafficCameraUseCases.saveCameraToggle(camera);
      // _updateAllCamerasValue(cameras);
      callback();
    }
  }

  // * PRIVATE METHODS

  void _initTimeago() {
    timeago.setLocaleMessages('en', AppTimeagoMessages());
  }

  void _initBox() async {
    Hive.init((await getApplicationDocumentsDirectory()).path);
    await Hive.openBox<TrafficCameraEntity>(BoxTagsHelper.cameras);
    updateSnapshots(isHideRefreshButton: false);
  }

  void _getLocalCameras() {
    final either = trafficCameraUseCases.getLocalSnapshots();

    either.fold(
        (left) => _onFailure(left), (right) => _updateAllCamerasValue(right));

    if (cameras.isNotEmpty) {
      _updateLastUpdated(dateTime: cameras.first.timestamp);
    }
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

  void _updateAllCamerasValue(List<TrafficCameraEntity> cameras) {
    this.cameras.value = cameras;
    savedCameras.value =
        this.cameras.where((element) => element.isSaved == true).toList();

    isHideRefreshButton.value = !isHideRefreshButton.value;
  }

  void _updateLastUpdated({DateTime? dateTime}) {
    _lastUpdated.value = dateTime ?? _lastUpdated.value;
    lastUpdatedString.value = _getLastUpdated();
  }

  void _change(RxStatus status) => change(null, status: status);
}
