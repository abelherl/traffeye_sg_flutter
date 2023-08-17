import 'dart:convert';

import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/0_datasource/exceptions/exceptions.dart';
import 'package:traffeye_sg_flutter/0_datasource/models/traffic_camera_model.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/api_helper.dart';

abstract class TrafficCameraDatasource {
  Future<List<TrafficCameraModel>> fetchSnapshotsFromRemote();
}

class TrafficCameraDatasourceImpl extends GetConnect implements TrafficCameraDatasource {

  @override
  Future<List<TrafficCameraModel>> fetchSnapshotsFromRemote() async {
    final response = await get(ApiHelper.trafficImagesUrl);

    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      final Map<String, dynamic> responseBody = json.decode(response.bodyString!);
      final List<dynamic> body = responseBody['items'][0]['cameras'];
      List<TrafficCameraModel> cameras = [];

      for (final camera in body) {
        cameras.add(TrafficCameraModel.fromJson(camera));
      }

      return cameras;
    }
  }
}
