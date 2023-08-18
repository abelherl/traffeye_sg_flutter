class LocationEntity {
  final String name;
  final double latitude;
  final double longitude;

  LocationEntity({
    this.name = '',
    required this.latitude,
    required this.longitude,
  });

  factory LocationEntity.fromJson(Map<String, dynamic> json) {
    return LocationEntity(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
