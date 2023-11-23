import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:traffeye_sg_flutter/0_datasource/exceptions/exceptions.dart';
import 'package:traffeye_sg_flutter/0_datasource/models/traffic_camera_model.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/api_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/box_tags_helper.dart';

abstract class TrafficCameraDatasource {
  Future<List<TrafficCameraModel>> fetchSnapshotsFromRemote();
  List<TrafficCameraEntity> fetchSnapshotsFromLocal();
  void update(TrafficCameraEntity camera);
  void updateAll(List<TrafficCameraEntity> cameras);
}

class TrafficCameraDatasourceImpl extends GetConnect
    implements TrafficCameraDatasource {

  final Client client;
  final Box<TrafficCameraEntity> box;

  TrafficCameraDatasourceImpl({required this.client, required this.box});

  @override
  Future<List<TrafficCameraModel>> fetchSnapshotsFromRemote() async {
    final response = await client.get(ApiHelper.trafficImagesUrl);

    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      final List<dynamic> body = responseBody['items'][0]['cameras'];
      List<TrafficCameraModel> cameras = [];

      for (final camera in body) {
        cameras.add(TrafficCameraModel.fromJson(camera));
      }

      return cameras;
    }
  }

  @override
  List<TrafficCameraEntity> fetchSnapshotsFromLocal() {
    final cameras = box.values.toList();
    return cameras;
  }

  @override
  void update(TrafficCameraEntity camera) async {
    try {
      box.put(camera.cameraId, camera);
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  void updateAll(List<TrafficCameraEntity> cameras) {
    try {
      for (final camera in cameras) {
        update(camera);
      }
    } catch (_) {
      throw CacheException();
    }
  }
}
