import 'package:either_dart/either.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/1_domain/failures/failures.dart';

abstract class TrafficCameraRepository {
  Future<Either<Failure, List<TrafficCameraEntity>>> getSnapshotsFromRemote();
}