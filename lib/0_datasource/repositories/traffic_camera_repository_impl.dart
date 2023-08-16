import 'package:either_dart/either.dart';
import 'package:traffeye_sg_flutter/0_datasource/datasources/traffic_camera_datasource.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/1_domain/failures/failures.dart';
import 'package:traffeye_sg_flutter/1_domain/repositories/traffic_camera_repository.dart';

class TrafficCameraRepositoryImpl implements TrafficCameraRepository {
  final TrafficCameraDatasource trafficCameraDatasource;

  TrafficCameraRepositoryImpl({required this.trafficCameraDatasource});

  @override
  Future<Either<Failure, List<TrafficCameraEntity>>> getSnapshotsFromRemote() async {
    await Future.delayed(const Duration(seconds: 2));
    return const Right([]);
  }
}