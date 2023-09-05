import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/camera_controller.dart';

class CameraDetailsController extends GetxController with StateMixin {
  final Rx<TrafficCameraEntity> camera;
  final Rx<String> customName = ''.obs;
  final isSaved = false.obs;
  final isChanged = false.obs;
  late final TrafficCameraEntity _initialCamera;

  CameraDetailsController({required this.camera});

  @override
  void onInit() {
    super.onInit();
    customName.value = camera.value.customName ?? '';
    isSaved.value = camera.value.isSaved;

    camera.value.customName = customName.value;
    _initialCamera = camera.value.copyWith(
        customName: customName.value);
  }

  void updateCustomName(String customName) {
    camera.value.customName = customName;
    this.customName.value = customName;
    _updateIsChanged();
  }

  void savedCameraToggle() {
    camera.value.isSaved = !camera.value.isSaved;
    isSaved.value = camera.value.isSaved;
    _updateIsChanged();
  }

  void updateCamera({required Function() callback}) =>
      Get.find<CameraController>()
          .saveCameraToggle(camera: camera.value, callback: callback);

  void _updateIsChanged() {
    final customNameChanged =
        _initialCamera.customName != camera.value.customName;
    final isSavedChanged = _initialCamera.isSaved != camera.value.isSaved;

    isChanged.value = customNameChanged || isSavedChanged;
  }
}
