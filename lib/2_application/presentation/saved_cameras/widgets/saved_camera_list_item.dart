import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/assets_path_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/app_list_card.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/camera_details/camera_details_pop_up.dart';
import 'package:traffeye_sg_flutter/2_application/widgets/themed_text.dart';

class SavedCameraListItem extends StatelessWidget {
  final TrafficCameraEntity camera;

  const SavedCameraListItem({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return AppListCard.normal(
      onPressed: () => CameraDetailsPopUp.openDialog(camera: camera),
      child: Row(
        children: [
          SvgPicture.asset(AssetsPathHelper.filledCamera),
          SizedBox(width: 16.w),
          Expanded(
            child: ThemedText(
              camera.getName(),
              themedTextStyle: ThemedTextStyle.body,
              maxLines: 2,
            ),
          ),
          SizedBox(width: 16.w),
          SvgPicture.asset(AssetsPathHelper.filledDraggable),
        ],
      ),
    );
  }
}
