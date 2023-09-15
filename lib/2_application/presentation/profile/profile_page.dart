import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/camera_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/app_list_card.dart';
import 'package:traffeye_sg_flutter/2_application/widgets/themed_text.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(IntlHelper.profile.tr),
        centerTitle: true,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(bottom: 100.w),
          child: Column(
            children: [
              ProfileSection(
                title: IntlHelper.personalization.tr,
                appListCards: [
                  AppListCard.profileBasic(
                    title: IntlHelper.cardWidgetsTitle.tr,
                    onPressed: () {},
                  ),
                  AppListCard.profileBasic(
                    title: IntlHelper.dashboardLayout.tr,
                    suffix: IntlHelper.carousel.tr,
                    onPressed: () {},
                  ),
                ],
              ),
              ProfileSection(
                title: IntlHelper.sections.tr,
                appListCards: [
                  AppListCard.profileSwitch(
                    title: IntlHelper.savedCameras.tr,
                    value: Get.find<CameraController>().isHideRefreshButton,
                  ),
                  AppListCard.profileSwitch(
                    title: IntlHelper.cardCamerasTitle.tr,
                    value: Get.find<CameraController>().isHideRefreshButton,
                  ),
                  AppListCard.profileSwitch(
                    title: IntlHelper.homeWidgetsTitle.tr,
                    value: Get.find<CameraController>().isHideRefreshButton,
                  ),
                ],
              ),
              ProfileSection(
                title: IntlHelper.other.tr,
                appListCards: [
                  AppListCard.profileBasic(
                    title: IntlHelper.about.tr,
                    onPressed: () {},
                  ),
                  AppListCard.profileBasic(
                    title: IntlHelper.donate.tr,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  final String title;
  final List<Widget> appListCards;

  const ProfileSection({
    super.key,
    required this.title,
    required this.appListCards,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16.w).copyWith(bottom: 0),
          child: ThemedText(
            title,
            themedTextStyle: ThemedTextStyle.title,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        ...appListCards,
      ],
    );
  }
}
