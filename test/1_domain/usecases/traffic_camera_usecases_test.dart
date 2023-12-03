import 'package:either_dart/either.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';
import 'package:traffeye_sg_flutter/0_datasource/repositories/traffic_camera_repository_impl.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/1_domain/failures/failures.dart';
import 'package:traffeye_sg_flutter/1_domain/usecases/traffic_camera_usecases.dart';

import '../../3_helpers/mock_helper.dart';
import 'traffic_camera_usecases_test.mocks.dart';

@GenerateNiceMocks([MockSpec<TrafficCameraRepositoryImpl>()])
void main() {
  group('TrafficCameraUsecases', () {
    group('should return List<TrafficCameraEntity>', () {
      test('when TrafficCameraRepositories returns a List<TrafficCameraEntity>',
          () async {
        final repositories = MockTrafficCameraRepositoryImpl();
        final usecases =
            TrafficCameraUseCases(trafficCameraRepository: repositories);
        final entities = MockHelper.mockCameras();

        MockHelper.initiateMockRepositories(
            repositories: repositories, entities: entities);

        final result = await usecases.getRemoteSnapshots();

        expect(result.isLeft, false);
        expect(result.isRight, true);
        expect(result, isA<Right<Failure, List<TrafficCameraEntity>>>());
        containsValue(entities);
      });
    });
  });
}
