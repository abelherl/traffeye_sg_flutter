import 'package:collection/collection.dart';
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
  Future<Either<Failure, List<TrafficCameraEntity>>>
      getSnapshotsFromRemote() async {
    try {
      List<TrafficCameraEntity> cameras = [];
      List<TrafficCameraEntity> camerasBoxList =
          trafficCameraDatasource.fetchSnapshotsFromLocal();

      final result = await trafficCameraDatasource.fetchSnapshotsFromRemote();

      for (final camera in result) {
        final camerasBox = camerasBoxList.firstWhereOrNull((element) => element.cameraId == camera.cameraId);
        final lat = camera.location.latitude;
        final long = camera.location.longitude;
        final placemarks = await placemarkFromCoordinates(lat, long);

        final location = LocationEntity(
          id: camera.cameraId,
          name: placemarks.firstOrNull?.street ?? '',
          latitude: lat,
          longitude: long,
        );

        final updatedCamera = (camerasBox ?? camera).copyWith(
          imageUrl: camera.imageUrl,
          timestamp: camera.timestamp,
          location: location,
        );

        cameras.add(updatedCamera);
        trafficCameraDatasource.update(updatedCamera);
      }
      return Right(cameras);
    } catch (_) {
      return Left(ConnectionFailure());
    }
  }

  @override
  Either<Failure, List<TrafficCameraEntity>> getSnapshotsFromLocal() {
    try {
      final cameras = trafficCameraDatasource.fetchSnapshotsFromLocal();

      return Right(cameras);
    } catch (_) {
      return Left(GeneralFailure());
    }
  }

  @override
  Either<Failure, List<TrafficCameraEntity>> getLocalSavedCameras() {
    try {
      final cameras = trafficCameraDatasource.fetchSnapshotsFromLocal();
      final savedCameras =
          cameras.where((element) => element.isSaved == true).toList();

      return Right(savedCameras);
    } catch (_) {
      return Left(GeneralFailure());
    }
  }

  @override
  Either<Failure, List<TrafficCameraEntity>> updateCamera(
      TrafficCameraEntity camera) {
    try {
      trafficCameraDatasource.update(camera);
      final updatedCameras =
          trafficCameraDatasource.fetchSnapshotsFromLocal().toList();
      return Right(updatedCameras);
    } catch (_) {
      return Left(GeneralFailure());
    }
  }

  @override
  Either<Failure, List<TrafficCameraEntity>> updateAllCameras(
      List<TrafficCameraEntity> cameras) {
    try {
      trafficCameraDatasource.updateAll(cameras);
      final updatedCameras =
          trafficCameraDatasource.fetchSnapshotsFromLocal().toList();
      return Right(updatedCameras);
    } catch (_) {
      return Left(GeneralFailure());
    }
  }
}
