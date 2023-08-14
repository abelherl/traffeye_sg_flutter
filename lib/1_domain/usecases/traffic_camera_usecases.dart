import 'package:either_dart/either.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/1_domain/failures/failures.dart';
import 'package:traffeye_sg_flutter/1_domain/repositories/traffic_camera_repository.dart';

class TrafficCameraUseCases {
  final TrafficCameraRepository trafficCameraRepository;

  TrafficCameraUseCases({required this.trafficCameraRepository});

  Future<Either<Failure, List<TrafficCameraEntity>>> getSnapshots() {
    return trafficCameraRepository.getSnapshotsFromRemote();
  }
}