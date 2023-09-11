import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/camera_controller.dart';

class ExploreCameraController extends GetxController {
  final _initialCameras = <TrafficCameraEntity>[].obs;
  final searchedCameras = <TrafficCameraEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    final cameraController = Get.find<CameraController>();
    final cameras = cameraController.cameras;
    _initialCameras.value = cameras;
    searchedCameras.value = cameras;
  }

  void searchFor(String keyword) {
    if (keyword == '') {
      searchedCameras.value = _initialCameras;
      return;
    }

    final newKeyword = keyword.toLowerCase();

    searchedCameras.value = _initialCameras.where((element) {
      final isNameFound = element.customName == null
          ? element.location.name.toLowerCase().contains(newKeyword)
          : element.customName!.toLowerCase().contains(newKeyword);

      return isNameFound;
    }).toList();
  }
}