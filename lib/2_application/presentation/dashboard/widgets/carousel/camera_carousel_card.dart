import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/style_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/app_ink_well.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/camera_details/camera_details_pop_up.dart';

class CameraCarouselCard extends StatelessWidget {
  final TrafficCameraEntity camera;

  const CameraCarouselCard({
    Key? key,
    required this.camera,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = StyleHelper.borderRadiusBig;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return CachedNetworkImage(
      imageUrl: camera.imageUrl,
      imageBuilder: (context, image) {
        return AspectRatio(
          aspectRatio: StyleHelper.ratioCarousel,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              image: DecorationImage(
                image: image,
                fit: BoxFit.fill,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                gradient: const LinearGradient(
                  colors: [Colors.transparent, Colors.black54],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.5, 1],
                ),
              ),
              child: AppInkWell(
                borderRadius: borderRadius,
                onPressed: () => camera.cameraId.isEmpty
                    ? null
                    : CameraDetailsPopUp.openDialog(camera: camera),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    camera.getName(),
                    style: theme.textTheme.displayLarge?.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
