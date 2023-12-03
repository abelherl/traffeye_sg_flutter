import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:mockito/mockito.dart';
import 'package:traffeye_sg_flutter/0_datasource/models/traffic_camera_model.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/1_domain/failures/failures.dart';

import '../1_domain/usecases/traffic_camera_usecases_test.mocks.dart';
import 'response_helper.dart';

abstract class MockHelper {
  static List<TrafficCameraEntity> mockCameras() {
    const responseBody = ResponseHelper.trafficCameraRemoteDatasourceValid;
    final decoded = json.decode(responseBody);
    final List<dynamic> body = decoded['items'][0]['cameras'];

    List<TrafficCameraEntity> entities = [];

    for (final camera in body) {
      final model = TrafficCameraModel.fromJson(camera);
      entities
          .add(TrafficCameraEntity.fromModel(model, location: model.location));
    }

    return entities;
  }

  static void provideCamerasDummy(
      {required List<TrafficCameraEntity> entities}) {
    provideDummy<Either<Failure, List<TrafficCameraEntity>>>(Right(entities));
  }

  static void initiateMockRepositories(
      {required MockTrafficCameraRepositoryImpl repositories,
      required List<TrafficCameraEntity> entities}) {
    provideDummy<Either<Failure, List<TrafficCameraEntity>>>(Right(entities));

    when(repositories.getSnapshotsFromRemote())
        .thenAnswer((realInvocation) => Future.value(Right(entities)));
    when(repositories.getSnapshotsFromLocal())
        .thenAnswer((realInvocation) => Right(entities));
    when(repositories.getLocalSavedCameras())
        .thenAnswer((realInvocation) => Right(entities));
    when(repositories.updateAllCameras(entities))
        .thenAnswer((realInvocation) => Right(entities));
    when(repositories.updateCamera(entities.first))
        .thenAnswer((realInvocation) => Right(entities));
  }
}
