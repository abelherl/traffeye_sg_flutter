import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:traffeye_sg_flutter/0_datasource/datasources/traffic_camera_datasource.dart';
import 'package:traffeye_sg_flutter/0_datasource/repositories/traffic_camera_repository_impl.dart';
import 'package:traffeye_sg_flutter/1_domain/repositories/traffic_camera_repository.dart';
import 'package:traffeye_sg_flutter/1_domain/usecases/traffic_camera_usecases.dart';

class AppInjections extends Bindings {
  @override
  void dependencies() {
    Get.put<TrafficCameraDatasource>(
        TrafficCameraDatasourceImpl(
            client: http.Client()));
    Get.put<TrafficCameraRepository>(
        TrafficCameraRepositoryImpl(
            trafficCameraDatasource: Get.find<TrafficCameraDatasource>()));
    Get.put<TrafficCameraUseCases>(
        TrafficCameraUseCases(
            trafficCameraRepository: Get.find<TrafficCameraRepository>()));
  }
}
