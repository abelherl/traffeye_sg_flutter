import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:traffeye_sg_flutter/0_datasource/models/traffic_camera_model.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/location_entity.dart';

@HiveType(typeId: 0)
class TrafficCameraEntity extends HiveObject with EquatableMixin {
  @HiveField(0)
  String cameraId;
  @HiveField(1)
  DateTime timestamp;
  @HiveField(2)
  String imageUrl;
  @HiveField(3)
  LocationEntity location;
  @HiveField(4)
  String? customName;
  @HiveField(5)
  bool isSaved;

  TrafficCameraEntity({
    required this.cameraId,
    required this.timestamp,
    required this.imageUrl,
    required this.location,
    this.customName,
    this.isSaved = false,
  });

  factory TrafficCameraEntity.fromModel(TrafficCameraModel model, {required LocationEntity location}) {
    return TrafficCameraEntity(
      cameraId: model.cameraId,
      timestamp: model.timestamp,
      imageUrl: model.imageUrl,
      location: location,
    );
  }

  TrafficCameraEntity copyWith({String? customName, bool? isSaved, LocationEntity? location}) {
    return TrafficCameraEntity(
      cameraId: cameraId,
      timestamp: timestamp,
      imageUrl: imageUrl,
      location: location ?? this.location,
      customName: customName,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  @override
  List<Object?> get props => [cameraId];
}
