import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/explore_camera_controller.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/map_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/unfocuser.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/explore_cameras/widgets/map_view.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/explore_cameras/widgets/search_camera_bottom_sheet.dart';
import 'package:traffeye_sg_flutter/theme.dart';

class ExploreCamerasPage extends StatelessWidget {
  const ExploreCamerasPage({Key? key}) : super(key: key);

  static const icons = [
    Icons.threesixty_rounded,
    Icons.add,
    Icons.account_circle_sharp
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(ExploreCameraController());
    Get.put(MapController());

    return Unfocuser(
      child: Scaffold(
        appBar: AppBar(
          title: Text(IntlHelper.cardCamerasTitle.tr),
          centerTitle: true,
        ),
        body: DraggableBottomSheet(
          minExtent: 110.w,
          expansionExtent: MediaQuery.of(context).size.height * 0.8,
          useSafeArea: false,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 50),
          barrierColor: AppTheme.barrierColor,
          previewWidget: const SearchCameraBottomSheet(isPreview: true),
          expandedWidget: const SearchCameraBottomSheet(),
          backgroundWidget: const MapView(),
          onDragging: (_) {},
        ),
      ),
    );
  }
}
