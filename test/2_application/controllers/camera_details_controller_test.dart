import 'dart:async';

import 'package:get/get.dart';
import 'package:test/test.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/camera_controller.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/camera_details_controller.dart';

import '../../3_helpers/mock_helper.dart';

void main() {
  group('CameraDetailsController', () {
    final camera = MockHelper.mockCameras().first.obs;
    final controller = CameraDetailsController(camera: camera);

    group('onInit() should initiate the value properly', () {
      test('when called', () async {
        Get.put<CameraDetailsController>(controller);
        expect(controller.camera.value, camera);
      });
    });

    group('updateCustomName() should update the value properly', () {
      void customNameChecker(
          {required String customName, required Matcher isChangedMatcher}) {
        expect(controller.customName.value, customName);
        expect(controller.camera.value.customName, customName);
        expect(controller.isChanged.value, isChangedMatcher);
      }

      test('when called and reverted', () async {
        final oldCustomName = camera.value.customName!;
        const newCustomName = 'Test';

        customNameChecker(customName: oldCustomName, isChangedMatcher: isFalse);

        controller.updateCustomName(newCustomName);
        customNameChecker(customName: newCustomName, isChangedMatcher: isTrue);

        controller.updateCustomName(oldCustomName);
        customNameChecker(customName: oldCustomName, isChangedMatcher: isFalse);
      });
    });

    group('savedCameraToggle() should update the value properly', () {
      void isSavedChecker(
          {required bool isSaved, required Matcher isChangedMatcher}) {
        expect(controller.isSaved.value, isSaved);
        expect(controller.camera.value.isSaved, isSaved);
        expect(controller.isChanged.value, isChangedMatcher);
      }

      test('when called and reverted', () async {
        final isSaved = camera.value.isSaved;

        isSavedChecker(isSaved: isSaved, isChangedMatcher: isFalse);

        controller.savedCameraToggle();
        isSavedChecker(isSaved: !isSaved, isChangedMatcher: isTrue);

        controller.savedCameraToggle();
        isSavedChecker(isSaved: isSaved, isChangedMatcher: isFalse);
      });
    });

    group('updateCamera() should update the value properly', () {
      void checkValueOf(TrafficCameraEntity entity) {
        expect(entity.customName, camera.value.customName);
        expect(entity.isSaved, camera.value.isSaved);
      }

      test('when called', () async {
        camera.value.customName = 'Test';
        camera.value.isSaved = true;

        MockHelper.generateCameraController(newEntity: camera.value);

        final cameraController = Get.find<CameraController>();
        final callback = Completer();

        controller.updateCamera(callback: () => callback.complete());

        checkValueOf(cameraController.cameras.first);
        checkValueOf(cameraController.savedCameras.first);
      });
    });
  });
}
