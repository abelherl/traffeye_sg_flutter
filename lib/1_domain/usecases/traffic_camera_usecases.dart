import 'package:either_dart/either.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/1_domain/failures/failures.dart';
import 'package:traffeye_sg_flutter/1_domain/repositories/traffic_camera_repository.dart';

class TrafficCameraUseCases {
  final TrafficCameraRepository trafficCameraRepository;

  TrafficCameraUseCases({required this.trafficCameraRepository});

  Future<Either<Failure, List<TrafficCameraEntity>>> getRemoteSnapshots() async {
    return await trafficCameraRepository.getSnapshotsFromRemote();
  }

  Either<Failure, List<TrafficCameraEntity>> getLocalSnapshots() {
    return trafficCameraRepository.getSnapshotsFromLocal();
  }

  Either<Failure, List<TrafficCameraEntity>> getLocalSavedCameras() {
    return trafficCameraRepository.getLocalSavedCameras();
  }

  Either<Failure, List<TrafficCameraEntity>> updateCamera(
      TrafficCameraEntity camera) {
    return trafficCameraRepository.updateCamera(camera);
  }

  Either<Failure, List<TrafficCameraEntity>> updateAllCameras(
      List<TrafficCameraEntity> cameras) {
    return trafficCameraRepository.updateAllCameras(cameras);
  }

  Either<Failure, List<TrafficCameraEntity>> saveCameraToggle(
      TrafficCameraEntity camera) {
    camera.isSaved = !camera.isSaved;
    return trafficCameraRepository.updateCamera(camera);
  }
}
