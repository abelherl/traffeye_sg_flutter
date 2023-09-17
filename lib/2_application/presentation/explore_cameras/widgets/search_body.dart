import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/explore_camera_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/app_scroll_view.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/warning_widget.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/dashboard/widgets/carousel/camera_carousel_card.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exploreController = Get.find<ExploreCameraController>();

    return Expanded(
      child: AppScrollView(
        padding: EdgeInsets.all(16.w).copyWith(top: 0),
        child: Obx(
          () => exploreController.searchedCameras.isEmpty
              ? WarningWidget(
                  title: IntlHelper.errorNoCamerasFoundTitle.tr,
                  subtitle: IntlHelper.errorNoCamerasFoundSubtitle.tr)
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: exploreController.searchedCameras.length,
                  separatorBuilder: (_, __) => SizedBox(height: 16.w),
                  itemBuilder: (context, index) => CameraCarouselCard(
                      camera: exploreController.searchedCameras[index])),
        ),
      ),
    );
  }
}
