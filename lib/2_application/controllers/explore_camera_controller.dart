import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/camera_controller.dart';

class ExploreCameraController extends GetxController {
  final initialCameras = <TrafficCameraEntity>[].obs;
  final searchedCameras = <TrafficCameraEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    final cameraController = Get.find<CameraController>();
    final cameras = cameraController.cameras;
    initialCameras.value = cameras;
    searchedCameras.value = cameras;
  }

  void searchFor(String keyword) {
    if (keyword == '') {
      searchedCameras.value = initialCameras;
      return;
    }

    searchedCameras.value = initialCameras.where((element) {
      late final bool isNameFound;

      if (element.customName == null) {
        isNameFound = element.location.name.contains(keyword);
      } else {
        isNameFound = element.customName!.contains(keyword);
      }

      return isNameFound;
    }).toList();
  }
}