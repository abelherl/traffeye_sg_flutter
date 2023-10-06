import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/style_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/app_ink_well.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/camera_details/camera_details_pop_up.dart';

class CameraGridCard extends StatelessWidget {
  final TrafficCameraEntity camera;

  const CameraGridCard({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    final borderRadius = StyleHelper.borderRadiusBig;

    return CachedNetworkImage(
      imageUrl: camera.imageUrl,
      imageBuilder: (context, image) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            image: DecorationImage(
              image: image,
              fit: BoxFit.fill,
            ),
          ),
          child: AppInkWell(
            borderRadius: borderRadius,
            onPressed: () => camera.cameraId.isEmpty
                ? null
                : CameraDetailsPopUp.openDialog(camera: camera),
            child: Container(),
          ),
        );
      },
    );
  }
}
