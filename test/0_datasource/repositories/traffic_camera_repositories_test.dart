import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:traffeye_sg_flutter/0_datasource/datasources/traffic_camera_datasource.dart';
import 'package:traffeye_sg_flutter/0_datasource/exceptions/exceptions.dart';
import 'package:traffeye_sg_flutter/0_datasource/models/traffic_camera_model.dart';
import 'package:traffeye_sg_flutter/0_datasource/repositories/traffic_camera_repository_impl.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/1_domain/failures/failures.dart';

import '../../3_helpers/response_helper.dart';
import 'traffic_camera_repositories_test.mocks.dart';

@GenerateNiceMocks([MockSpec<TrafficCameraDatasourceImpl>()])
void main() {
  group('TrafficCameraRemoteRepositories', () {
    final datasource = MockTrafficCameraDatasourceImpl();
    final repositories =
        TrafficCameraRepositoryImpl(trafficCameraDatasource: datasource);

    group('should return Right with a list of TrafficCameraEntities', () {
      test('when TrafficCameraDatasource returns a list of TrafficCameraModels',
          () async {
        const responseBody = ResponseHelper.trafficCameraRemoteDatasourceValid;
        final decoded = json.decode(responseBody);
        final List<dynamic> body = decoded['items'][0]['cameras'];

        List<TrafficCameraEntity> entities = [];

        for (final camera in body) {
          final model = TrafficCameraModel.fromJson(camera);
          entities.add(
              TrafficCameraEntity.fromModel(model, location: model.location));
        }

        final result = await repositories.getSnapshotsFromRemote();

        expect(result.isLeft, false);
        expect(result.isRight, true);
        expect(result, isA<Right<Failure, List<TrafficCameraEntity>>>());
        containsValue(entities.first);
      });
    });

    group('should return Left with', () {
      test('ServerFailure when ServerException occurs', () async {
        when(datasource.fetchSnapshotsFromRemote())
            .thenThrow(ServerException());

        final result = await repositories.getSnapshotsFromRemote();

        expect(result.isLeft, true);
        expect(result.isRight, false);
        expect(
            result, Left<Failure, List<TrafficCameraEntity>>(ServerFailure()));
      });

      test('GeneralFailure when other types of exceptions occurs', () async {
        when(datasource.fetchSnapshotsFromRemote()).thenThrow(CacheException());

        final result = await repositories.getSnapshotsFromRemote();

        expect(result.isLeft, true);
        expect(result.isRight, false);
        expect(
            result, Left<Failure, List<TrafficCameraEntity>>(GeneralFailure()));
      });
    });
  });
}
