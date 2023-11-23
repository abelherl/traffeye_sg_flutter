import 'package:equatable/equatable.dart';
import 'package:traffeye_sg_flutter/0_datasource/exceptions/exceptions.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/location_entity.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';

class TrafficCameraModel extends TrafficCameraEntity with EquatableMixin {
  TrafficCameraModel(
      {required super.cameraId,
      required super.timestamp,
      required super.imageUrl,
      required super.location});

  factory TrafficCameraModel.fromJson(Map json) {
    try {
      return TrafficCameraModel(
        timestamp: DateTime.parse(json['timestamp']),
        imageUrl: json['image'],
        location: LocationEntity.fromJson(json['camera_id'], json['location']),
        cameraId: json['camera_id'],
      );
    } catch (e) {
      throw TypeException();
    }
  }
}
