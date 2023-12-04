import 'dart:async';

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
    final entities = MockHelper.mockCameras();

    SharedPreferences.setMockInitialValues({});

    MockHelper.initiateMockRepositories(
        repositories: repositories, entities: entities);

    Get.put<CameraController>(controller);

    group('onInit() should run properly', () {
      test('when called', () async {
        await Future.delayed(const Duration(milliseconds: 100), () {});

        expect(controller.cameras, entities);
      });
    });

    group('updateSnapshots() should update the snapshots', () {
      test('when called', () async {
        controller.updateSnapshots();

        await Future.delayed(const Duration(milliseconds: 100), () {});

        expect(controller.cameras, entities);
      });
    });

    group('updateCamera() should update the camera', () {
      test('when called', () async {
        final camera = MockHelper.mockCameras().first;
        final callback = Completer<void>();

        controller.updateCamera(
            camera: camera, callback: () => callback.complete());

        await Future.delayed(const Duration(milliseconds: 100), () {});

        expect(callback.isCompleted, isTrue);
        expect(controller.cameras.contains(camera), isTrue);
      });
    });
  });
}
