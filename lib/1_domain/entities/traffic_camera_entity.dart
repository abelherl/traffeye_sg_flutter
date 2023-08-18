import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:traffeye_sg_flutter/0_datasource/models/traffic_camera_model.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/location_entity.dart';

class TrafficCameraEntity with EquatableMixin {
  final String cameraId;
  final DateTime timestamp;
  final String imageUrl;
  final LocationEntity location;

  const TrafficCameraEntity({
    required this.cameraId,
    required this.timestamp,
    required this.imageUrl,
    required this.location,
  });

  factory TrafficCameraEntity.fromModel(TrafficCameraModel model, {required LocationEntity location}) {
    return TrafficCameraEntity(
      cameraId: model.cameraId,
      timestamp: model.timestamp,
      imageUrl: model.imageUrl,
      location: location,
    );
  }

  @override
  List<Object?> get props => [cameraId];
}
