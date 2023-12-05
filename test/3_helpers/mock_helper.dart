import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traffeye_sg_flutter/0_datasource/models/traffic_camera_model.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/location_entity.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/1_domain/failures/failures.dart';
import 'package:traffeye_sg_flutter/1_domain/usecases/traffic_camera_usecases.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/camera_controller.dart';

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
      TrafficCameraEntity entity =
          TrafficCameraEntity.fromModel(model, location: model.location);
      entity.customName = 'Custom Name';
      entity.isSaved = true;
      entities.add(entity);
    }

    return entities;
  }

  static LocationEntity mockLocation() {
    return mockCameras().first.location;
  }

  static void provideCamerasDummy(
      {required List<TrafficCameraEntity> entities}) {
    provideDummy<Either<Failure, List<TrafficCameraEntity>>>(Right(entities));
  }

  static void initiateMockRepositories(
      {required MockTrafficCameraRepositoryImpl repositories,
      required List<TrafficCameraEntity> entities,
      TrafficCameraEntity? newEntity}) {
    provideDummy<Either<Failure, List<TrafficCameraEntity>>>(Right(entities));

    List<TrafficCameraEntity> updatedEntities = entities;

    if (newEntity != null) {
      updatedEntities.first = newEntity;
    }

    when(repositories.getSnapshotsFromRemote())
        .thenAnswer((realInvocation) => Future.value(Right(updatedEntities)));
    when(repositories.getSnapshotsFromLocal())
        .thenAnswer((realInvocation) => Right(updatedEntities));
    when(repositories.getLocalSavedCameras())
        .thenAnswer((realInvocation) => Right(updatedEntities));
    when(repositories.updateAllCameras(updatedEntities))
        .thenAnswer((realInvocation) => Right(updatedEntities));
    when(repositories.updateCamera(updatedEntities.first))
        .thenAnswer((realInvocation) => Right(updatedEntities));
  }

  static generateCameraController(
      {List<TrafficCameraEntity>? entities, TrafficCameraEntity? newEntity}) {
    final repositories = MockTrafficCameraRepositoryImpl();

    MockHelper.initiateMockRepositories(
      repositories: repositories,
      entities: entities ?? MockHelper.mockCameras(),
      newEntity: newEntity,
    );

    SharedPreferences.setMockInitialValues({});

    Get.put(TrafficCameraUseCases(trafficCameraRepository: repositories));
    Get.put(CameraController());
  }
}
