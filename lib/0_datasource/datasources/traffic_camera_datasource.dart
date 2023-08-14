import 'dart:convert';

import 'package:traffeye_sg_flutter/0_datasource/exceptions/exceptions.dart';
import 'package:traffeye_sg_flutter/0_datasource/models/traffic_camera_model.dart';
import 'package:http/http.dart' as http;
import 'package:traffeye_sg_flutter/2_application/core/helpers/constant_api_helper.dart';

abstract class TrafficCameraDatasource {
  Future<List<dynamic>> fetchSnapshotsFromRemote();
}

class TrafficCameraDatasourceImpl implements TrafficCameraDatasource {
  final http.Client client;
  TrafficCameraDatasourceImpl({required this.client});

  @override
  Future<List<TrafficCameraModel>> fetchSnapshotsFromRemote() async {
    final response =
        await client.get(Uri.parse(ConstantApiHelper.trafficImagesUrl));

    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      List<TrafficCameraModel> cameras = [];
      List<Map<String, dynamic>> responseBody =
          json.decode(response.body)['items'][0]['cameras'];

      for (final camera in responseBody) {
        cameras.add(TrafficCameraModel.fromJson(camera));
      }

      return cameras;
    }
  }
}
