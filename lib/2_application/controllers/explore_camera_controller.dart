import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/camera_controller.dart';

class ExploreCameraController extends GetxController {
  final _initialCameras = <TrafficCameraEntity>[].obs;
  final _keyword = ''.obs;
  final searchedCameras = <TrafficCameraEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    final cameraController = Get.find<CameraController>();
    final cameras = cameraController.cameras;

    _initialCameras.value = cameras;
    searchedCameras.value = cameras;

    cameras.stream.listen((cameras) {
      _initialCameras.value = cameras;
      searchFor(_keyword.value);
    });
  }

  void searchFor(String keyword) {
    _keyword.value = keyword;

    if (keyword == '') {
      searchedCameras.value = _initialCameras;
      return;
    }

    final newKeyword = keyword.toLowerCase();

    searchedCameras.value = _initialCameras.where((element) {
      final isLocationNameFound =
          element.location.name.toLowerCase().contains(newKeyword);
      late final bool isCustomNameFound;

      if (element.isCustomNameEmpty()) {
        isCustomNameFound = false;
      } else {
        isCustomNameFound =
            element.customName!.toLowerCase().contains(newKeyword);
      }

      return isLocationNameFound || isCustomNameFound;
    }).toList();
  }
}
