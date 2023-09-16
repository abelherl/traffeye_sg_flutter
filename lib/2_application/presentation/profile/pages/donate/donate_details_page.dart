import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/url_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/app_list_card.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/profile/widgets/profile_details_page.dart';

class DonateDetailsPage extends StatelessWidget {
  const DonateDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileDetailsPage(
      pageTitle: IntlHelper.donate.tr,
      title: IntlHelper.donateTitle.tr,
      description: IntlHelper.donateTexts.tr,
      cards: [
        ProfileRedirectListCard(
          title: IntlHelper.donateButton.tr,
          url: UrlHelper.donate,
        )
      ],
    );
  }
}
