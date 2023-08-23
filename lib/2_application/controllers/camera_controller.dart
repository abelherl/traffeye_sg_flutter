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
  final trafficCameraUseCases = Get.find<TrafficCameraUseCases>();

  List<TrafficCameraEntity> get savedCameras =>
      cameras.where((camera) => camera.isSaved == true).toList();

  @override
  void onInit() {
    super.onInit();
    _initTimeago();
    _initBox();
    updateSnapshots();
    _refreshLastUpdated();
  }

  void _initTimeago() {
    timeago.setLocaleMessages('en', AppTimeagoMessages());

    if (cameras.isNotEmpty) {
      _lastUpdated.value = cameras.firstOrNull!.timestamp;
      lastUpdatedString.value = _getLastUpdated();
    }
  }

  void updateSnapshots() async {
    _change(RxStatus.loading());

    final either = await trafficCameraUseCases.getRemoteSnapshots();

    either.fold((left) => _onFailure(left), (right) {
      _lastUpdated.value = DateTime.now();
      lastUpdatedString.value = _getLastUpdated();
      cameras.value = right;

      _change(RxStatus.success());
    });
  }

  void saveCameraToggle({required TrafficCameraEntity camera}) {
    final index = cameras.indexWhere((element) => element == camera);
    if (index != -1) {
      cameras[index].isSaved = !cameras[index].isSaved;
      trafficCameraUseCases.updateCamera(camera);
    }
  }

  void _onFailure(Failure failure) {
    _change(RxStatus.error());
    AppSnackBar.showSnackBar(AppSnackBarData.fromFailure(failure));
  }

  void _initBox() async {
    Hive.init((await getApplicationDocumentsDirectory()).path);
    await Hive.openBox<TrafficCameraEntity>(BoxTagsHelper.cameras);
    _getLocalCameras();
  }

  void _getLocalCameras() async {
    final either = trafficCameraUseCases.getLocalSnapshots();

    either.fold(
        (left) => _onFailure(left),
        (right) => cameras.value = right);
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
