import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/profile/widgets/profile_details_page.dart';

class HomeWidgetsDetails extends StatelessWidget {
  const HomeWidgetsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileDetailsPage(
      pageTitle: IntlHelper.cardWidgetsTitle.tr,
      title: IntlHelper.homeWidgetsTitle.tr,
      description: IntlHelper.homeWidgetsTexts.tr,
      cards: const [],
    );
  }
}
