import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:traffeye_sg_flutter/0_datasource/models/traffic_camera_model.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/location_entity.dart';

@HiveType(typeId: 0)
class TrafficCameraEntity with EquatableMixin {
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
  @HiveField(6)
  int? sortIndex;

  TrafficCameraEntity({
    required this.cameraId,
    required this.timestamp,
    required this.imageUrl,
    required this.location,
    this.customName,
    this.isSaved = false,
    this.sortIndex,
  });

  factory TrafficCameraEntity.fromModel(TrafficCameraModel model,
      {required LocationEntity location}) {
    return TrafficCameraEntity(
      cameraId: model.cameraId,
      timestamp: model.timestamp,
      imageUrl: model.imageUrl,
      location: location,
    );
  }

  TrafficCameraEntity copyWith(
      {String? customName,
      bool? isSaved,
      LocationEntity? location,
      String? imageUrl,
      DateTime? timestamp,
      int? sortIndex}) {
    return TrafficCameraEntity(
      cameraId: cameraId,
      timestamp: timestamp ?? this.timestamp,
      imageUrl: imageUrl ?? this.imageUrl,
      location: location ?? this.location,
      customName: customName ?? this.customName,
      isSaved: isSaved ?? this.isSaved,
      sortIndex: sortIndex ?? this.sortIndex,
    );
  }

  String getName() {
    if (customName == null) {
      return location.name;
    }

    if (customName!.trim().isEmpty) {
      return location.name;
    }

    return customName!;
  }

  bool isCustomNameEmpty() {
    if (customName == null) {
      return true;
    }

    if (customName!.trim().isEmpty) {
      return true;
    }

    return false;
  }

  @override
  List<Object?> get props => [cameraId];
}

class TrafficCameraAdapter extends TypeAdapter<TrafficCameraEntity> {
  @override
  final typeId = 0;

  @override
  TrafficCameraEntity read(BinaryReader reader) {
    return TrafficCameraEntity(
      cameraId: reader.read(),
      timestamp: reader.read(),
      imageUrl: reader.read(),
      location: reader.read(),
      customName: reader.read(),
      isSaved: reader.read(),
      sortIndex: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, TrafficCameraEntity obj) {
    writer
      ..write(obj.cameraId)
      ..write(obj.timestamp)
      ..write(obj.imageUrl)
      ..write(obj.location)
      ..write(obj.customName)
      ..write(obj.isSaved)
      ..write(obj.sortIndex);
  }
}
