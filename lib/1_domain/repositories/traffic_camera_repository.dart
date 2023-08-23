import 'package:either_dart/either.dart';

import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/1_domain/failures/failures.dart';

abstract class TrafficCameraRepository {
  Future<Either<Failure, List<TrafficCameraEntity>>> getSnapshotsFromRemote();
  Either<Failure, List<TrafficCameraEntity>> getSnapshotsFromLocal();
  Either<Failure, List<TrafficCameraEntity>> updateCamera(TrafficCameraEntity camera);
  Either<Failure, List<TrafficCameraEntity>> updateAllCameras(List<TrafficCameraEntity> cameras);
}