import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/assets_path_helper.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/dashboard/widgets/features_section.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/dashboard/widgets/saved_cameras_section.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        height: double.infinity,
        color: colorScheme.background,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [colorScheme.primary, colorScheme.primaryContainer],
                    center: Alignment.topRight,
                    radius: 1.3,
                  ),
                ),
                alignment: Alignment.centerLeft,
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Hero(
                      tag: 'logo',
                      child: SvgPicture.asset(
                        AssetsPathHelper.filledLogo,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SavedCamerasSection(),
                    SizedBox(height: 24.w),
                    const FeaturesSection(),
                    SizedBox(height: 24.w),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
