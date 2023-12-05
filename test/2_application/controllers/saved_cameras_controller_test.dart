import 'package:get/get.dart';
import 'package:test/test.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/saved_cameras_controller.dart';

import '../../3_helpers/mock_helper.dart';

void main() {
  group('SavedCamerasController', () {
    final cameras = MockHelper.mockSavedCameras();
    MockHelper.generateCameraController(entities: cameras);

    final controller = SavedCamerasController();

    group('onInit() should initiate the value properly', () {
      test('when called', () async {
        Get.put<SavedCamerasController>(controller);
        expect(controller.savedCameras, cameras);
      });
    });

    group('reorder() should change the value properly', () {
      test('when called', () async {
        controller.reorder(0, 0, 1, 0);
        expect(controller.cameraController.savedCameras.first.cameraId, '1002');
      });
    });
  });
}
