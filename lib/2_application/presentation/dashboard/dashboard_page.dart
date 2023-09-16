import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/app_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/assets_path_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/warning_widget.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/dashboard/widgets/features_section.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/dashboard/widgets/saved_cameras_section.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [colorScheme.primary, colorScheme.primaryContainer],
              center: Alignment.topRight,
              radius: 4,
            ),
          ),
        ),
        title: Row(
          children: [
            Hero(
              tag: 'logo',
              child: SvgPicture.asset(
                AssetsPathHelper.filledLogo,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        color: colorScheme.background,
        child: Obx(
          () {
            if (!controller.isSavedCamerasActive.value &&
                !controller.isExploreCamerasActive.value &&
                !controller.isHomeWidgetsActive.value) {
              return WarningWidget(
                title: IntlHelper.errorNoActivatedSectionsTitle.tr,
                subtitle: IntlHelper.errorNoActivatedSectionsSubtitle.tr,
              );
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.w),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SavedCamerasSection(),
                    FeaturesSection(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
