import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/app_list_card.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/profile/pages/about/about_details_page.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/profile/pages/donate/donate_details_page.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/profile/widgets/profile_section.dart';

class OtherSection extends StatelessWidget {
  const OtherSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileSection(
      title: IntlHelper.other.tr,
      appListCards: [
        ProfileBasicListCard(
          title: IntlHelper.about.tr,
          onPressed: () => Get.to(const AboutDetailsPage()),
        ),
        ProfileBasicListCard(
          title: IntlHelper.donate.tr,
          onPressed: () => Get.to(const DonateDetailsPage()),
        ),
      ],
    );
  }
}