import 'dart:convert';

import 'package:traffeye_sg_flutter/0_datasource/models/traffic_camera_model.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';

import 'response_helper.dart';

abstract class MockHelper {

  static List<TrafficCameraEntity> mockCameras() {
    const responseBody = ResponseHelper.trafficCameraRemoteDatasourceValid;
    final decoded = json.decode(responseBody);
    final List<dynamic> body = decoded['items'][0]['cameras'];

    List<TrafficCameraEntity> entities = [];

    for (final camera in body) {
      final model = TrafficCameraModel.fromJson(camera);
      entities.add(
          TrafficCameraEntity.fromModel(model, location: model.location));
    }

    return entities;
  }
}