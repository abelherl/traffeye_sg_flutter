import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/map_controller.dart';

class ExploreCamerasPage extends StatelessWidget {
  const ExploreCamerasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapController = Get.put(MapController());

    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(1.290270, 103.851959),
          zoom: 11.0,
        ),
        onMapCreated: (controller) => mapController.setController(controller),
        markers: {
          const Marker(
            markerId: MarkerId('Singapore'),
            position: LatLng(1.290270, 103.851959),
          ),
        },
      ),
    );
  }
}
