import 'package:get/get.dart';
import 'package:test/test.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/explore_camera_controller.dart';

import '../../3_helpers/mock_helper.dart';

void main() {
  group('ExploreCameraController', () {
    final controller = ExploreCameraController();
    List<TrafficCameraEntity> cameras = MockHelper.mockCameras();

    cameras.add(TrafficCameraEntity.empty().copyWith(customName: 'QWERTY'));

    MockHelper.generateCameraController(entities: cameras);

    group('onInit() should initiate the value properly', () {
      test('when called', () async {
        Get.put<ExploreCameraController>(controller);

        expect(controller.searchedCameras, cameras);
      });
    });

    group('searchFor() should return the proper value', () {
      void expectWithKeywordAndLength(String keyword, int length) {
        expect(controller.searchedCameras.length, length);
        expect(
            controller.searchedCameras.any((item) =>
                item.customName?.toLowerCase() == keyword.toLowerCase()),
            isTrue);
      }

      test('when keyword is not empty', () {
        final keyword = cameras.first.customName!;
        controller.searchFor(keyword);

        expectWithKeywordAndLength(keyword, 1);
      });

      test('when keyword have capital letters', () {
        final keyword = cameras.first.customName!.toUpperCase();
        controller.searchFor(keyword);

        expectWithKeywordAndLength(keyword, 1);
      });

      test('when keyword is empty', () {
        const keyword = '';
        controller.searchFor(keyword);

        expect(controller.searchedCameras.length, 2);
      });
    });
  });
}
