import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class LocationEntity extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double latitude;
  @HiveField(3)
  final double longitude;

  LocationEntity({
    required this.id,
    this.name = '',
    required this.latitude,
    required this.longitude,
  });

  factory LocationEntity.fromJson(String id, Map<String, dynamic> json) {
    return LocationEntity(
      id: id,
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class LocationAdapter extends TypeAdapter<LocationEntity> {
  @override
  final typeId = 1;

  @override
  LocationEntity read(BinaryReader reader) {
    return LocationEntity(
      id: reader.read(),
      name: reader.read(),
      latitude: reader.read(),
      longitude: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, LocationEntity obj) {
    writer
      ..write(obj.id)
      ..write(obj.name)
      ..write(obj.latitude)
      ..write(obj.longitude);
  }
}

