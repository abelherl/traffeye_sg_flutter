import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/app_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/assets_path_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/dashboard/widgets/features_card_base.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/explore_cameras/explore_cameras_page.dart';
import 'package:traffeye_sg_flutter/2_application/widgets/themed_text.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (controller.isExploreCamerasActive.value ||
                controller.isHomeWidgetsActive.value)...[
              ThemedText(
                IntlHelper.features.tr,
                themedTextStyle: ThemedTextStyle.title,
              ),
              SizedBox(height: 16.w),
            ],
            if (controller.isExploreCamerasActive.value)...[
              FeaturesCardBase(
                imagePath: AssetsPathHelper.imagesExplore,
                title: IntlHelper.cardCamerasTitle.tr,
                subtitle: IntlHelper.cardCamerasSubtitle.tr,
                onPressed: () => Get.to(() => const ExploreCamerasPage()),
              ),
              SizedBox(height: 16.w),
            ],
            if (controller.isHomeWidgetsActive.value)...[
              FeaturesCardBase(
                imagePath: AssetsPathHelper.imagesWidget,
                title: IntlHelper.cardWidgetsTitle.tr,
                subtitle: IntlHelper.cardWidgetsSubtitle.tr,
                onPressed: () => Get.to(() => const ExploreCamerasPage()),
              ),
              SizedBox(height: 80.w),
            ]
          ],
        ),
      ),
    );
  }
}
