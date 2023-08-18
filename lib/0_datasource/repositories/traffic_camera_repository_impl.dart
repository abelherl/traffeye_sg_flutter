import 'package:either_dart/either.dart';
import 'package:geocoding/geocoding.dart';
import 'package:traffeye_sg_flutter/0_datasource/datasources/traffic_camera_datasource.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/location_entity.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/1_domain/failures/failures.dart';
import 'package:traffeye_sg_flutter/1_domain/repositories/traffic_camera_repository.dart';

class TrafficCameraRepositoryImpl implements TrafficCameraRepository {
  final TrafficCameraDatasource trafficCameraDatasource;

  TrafficCameraRepositoryImpl({required this.trafficCameraDatasource});

  @override
  Future<Either<Failure, List<TrafficCameraEntity>>> getSnapshotsFromRemote() async {
    try {
      List<TrafficCameraEntity> cameras = [];
      final result = await trafficCameraDatasource.fetchSnapshotsFromRemote();
      for (var camera in result) {
        final lat = camera.location.latitude;
        final long = camera.location.longitude;
        final placemarks = await placemarkFromCoordinates(lat, long);

        final location = LocationEntity(
          name: placemarks.firstOrNull?.street ?? '',
          latitude: lat,
          longitude: long,
        );

        cameras.add(TrafficCameraEntity.fromModel(
            camera,
            location: location));
      }
      return Right(cameras);
    } catch (_) {
      return Left(ConnectionFailure());
    }
  }
}