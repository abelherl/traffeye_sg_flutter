import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/app_scroll_view.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/profile/sections/dashboard_section.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/profile/sections/other_section.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/profile/sections/personalization_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(IntlHelper.profile.tr),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: AppScrollView(
          padding: EdgeInsets.only(bottom: 100.w),
          child: const Column(
            children: [
              PersonalizationSection(),
              DashboardSection(),
              OtherSection(),
            ],
          ),
        ),
      ),
    );
  }
}

