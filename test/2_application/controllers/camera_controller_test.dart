import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:traffeye_sg_flutter/1_domain/usecases/traffic_camera_usecases.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/camera_controller.dart';

import '../../1_domain/usecases/traffic_camera_usecases_test.mocks.dart';
import '../../3_helpers/mock_helper.dart';

void main() {
  group('CameraController', () {
    final repositories = MockTrafficCameraRepositoryImpl();
    final usecases =
        TrafficCameraUseCases(trafficCameraRepository: repositories);

    Get.put<TrafficCameraUseCases>(usecases);

    final controller = CameraController();

    SharedPreferences.setMockInitialValues({});

    group('onInit() should run properly', () {
      test('when called', () async {
        final entities = MockHelper.mockCameras();

        MockHelper.initiateMockRepositories(
            repositories: repositories, entities: entities);

        Get.put<CameraController>(controller);

        await Future.delayed(const Duration(seconds: 1), (){});

        expect(controller.cameras, entities);
      });
    });
  });
}
