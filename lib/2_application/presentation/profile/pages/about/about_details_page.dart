import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/url_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/app_list_card.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/profile/widgets/profile_details_page.dart';

class AboutDetailsPage extends StatelessWidget {
  const AboutDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      {
        'title': IntlHelper.aboutFlutter,
        'url': UrlHelper.flutter,
      },
      {
        'title': IntlHelper.aboutIconsax,
        'url': UrlHelper.iconsax,
      },
      {
        'title': IntlHelper.aboutUnsplash,
        'url': UrlHelper.unsplash,
      },
      {
        'title': IntlHelper.aboutCameraApi,
        'url': UrlHelper.cameraApi,
      },
      {
        'title': IntlHelper.aboutFigma,
        'url': UrlHelper.traffEyeFigma,
      },
      {
        'title': IntlHelper.aboutGitHub,
        'url': UrlHelper.traffEyeGitHub,
      },
    ];

    return ProfileDetailsPage(
        pageTitle: IntlHelper.about.tr,
        title: IntlHelper.aboutTitle.tr,
        description: IntlHelper.aboutTexts.tr,
        cards: data.map((e) =>
            ProfileRedirectListCard(
                title: e['title']!.tr,
                url: e['url']!)).toList());
  }
}
