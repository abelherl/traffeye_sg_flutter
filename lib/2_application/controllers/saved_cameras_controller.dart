import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/camera_controller.dart';

class SavedCamerasController extends GetxController {
  final isEditing = false.obs;
  final _initialCameras = <TrafficCameraEntity>[].obs;
  final savedCameras = <TrafficCameraEntity>[].obs;
  final cameraController = Get.find<CameraController>();

  @override
  void onInit() {
    super.onInit();

    final cameras = cameraController.savedCameras;

    _initialCameras.value = cameras;
    savedCameras.value = cameras;

    cameras.stream.listen((cameras) {
      _initialCameras.value = cameras;
    });
  }

  void isEditingToggle() => isEditing.toggle();

  void reorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    final movedItem = savedCameras.removeAt(oldItemIndex);
    savedCameras.insert(newItemIndex, movedItem);
  }

  void updateSavedCameras() {
    cameraController.updateCameras(cameras: savedCameras);
  }
}
