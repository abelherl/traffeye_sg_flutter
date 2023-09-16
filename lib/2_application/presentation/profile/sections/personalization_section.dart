import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/app_list_card.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/profile/widgets/profile_details_page.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/profile/widgets/profile_section.dart';

class PersonalizationSection extends StatelessWidget {
  const PersonalizationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileSection(
      title: IntlHelper.personalization.tr,
      appListCards: [
        ProfileBasicListCard(
          title: IntlHelper.cardWidgetsTitle.tr,
          onPressed: () => Get.to(
            ProfileDetailsPage(
              pageTitle: IntlHelper.cardWidgetsTitle.tr,
              title: IntlHelper.homeWidgetsTitle.tr,
              description: IntlHelper.homeWidgetsTexts.tr,
              cards: [
                ProfileBasicListCard(title: 'title', onPressed: () {}),
              ],
            ),
          ),
        ),
        ProfileBasicListCard(
          title: IntlHelper.dashboardLayout.tr,
          suffix: IntlHelper.carousel.tr,
          onPressed: () {},
        ),
      ],
    );
  }
}