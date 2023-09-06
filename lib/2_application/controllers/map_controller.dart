import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/assets_path_helper.dart';

class MapController extends GetxController {
  final _mapStyle = ''.obs;
  late final GoogleMapController _mapController;

  @override
  void onInit() {
    super.onInit();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      rootBundle.loadString(AssetsPathHelper.styleMap).then((string) {
        _mapStyle.value = string;
      });
    });
  }

  void setController(GoogleMapController controller) {
    _mapController = controller;
    _mapController.setMapStyle(_mapStyle.value);
  }
}