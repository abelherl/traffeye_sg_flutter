import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/assets_path_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/style_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/app_ink_well.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/camera_details/camera_details_pop_up.dart';
import 'package:traffeye_sg_flutter/2_application/widgets/themed_text.dart';
import 'package:traffeye_sg_flutter/theme.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class AppListCard implements Widget {}

// * Base card

class _BaseAppListCard extends StatelessWidget {
  final Widget child;
  final Function() onPressed;

  const _BaseAppListCard({
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.w).copyWith(bottom: 0),
      height: 70.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: StyleHelper.borderRadiusBig,
      ),
      child: AppInkWell(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        onPressed: onPressed,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

class _BaseSmallAppListCard extends StatelessWidget implements AppListCard {
  final Widget child;
  final Function() onPressed;

  const _BaseSmallAppListCard({
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.w).copyWith(bottom: 0),
      height: 50.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: StyleHelper.borderRadiusSmall,
      ),
      child: AppInkWell(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12),
        borderRadius: StyleHelper.borderRadiusSmall,
        onPressed: onPressed,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

// * Card variants

class CameraAppListCard extends StatelessWidget implements AppListCard {
  final TrafficCameraEntity camera;

  const CameraAppListCard({
    super.key,
    required this.camera,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseAppListCard(
      onPressed: () => CameraDetailsPopUp.openDialog(camera: camera),
      child: Row(
        children: [
          SvgPicture.asset(AssetsPathHelper.filledCamera),
          SizedBox(width: 16.w),
          Expanded(
            child: ThemedText(
              camera.getName(),
              themedTextStyle: ThemedTextStyle.body,
              maxLines: 2,
            ),
          ),
          SizedBox(width: 16.w),
          SvgPicture.asset(AssetsPathHelper.filledDraggable),
        ],
      ),
    );
  }
}

class ProfileBasicListCard extends StatelessWidget implements AppListCard {
  final String title;
  final Function() onPressed;
  final String suffix;

  const ProfileBasicListCard({
    super.key,
    required this.title,
    required this.onPressed,
    this.suffix = '',
  });

  @override
  Widget build(BuildContext context) {
    return _BaseSmallAppListCard(
      onPressed: onPressed,
      child: Row(
        children: [
          Expanded(
            child: ThemedText(
              title,
              themedTextStyle: ThemedTextStyle.body,
              maxLines: 2,
            ),
          ),
          SizedBox(width: 10.w),
          ThemedText(
            suffix,
            themedTextStyle: ThemedTextStyle.caption,
            color: AppTheme.lightCaptionColor,
            maxLines: 1,
          ),
          SizedBox(width: 10.w),
          SvgPicture.asset(AssetsPathHelper.filledNext),
        ],
      ),
    );
  }
}

class ProfileRedirectListCard extends StatelessWidget implements AppListCard {
  final String title;
  final String url;

  const ProfileRedirectListCard({
    super.key,
    required this.title,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseSmallAppListCard(
      onPressed: () => launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      ),
      child: Row(
        children: [
          Expanded(
            child: ThemedText(
              title,
              themedTextStyle: ThemedTextStyle.body,
              maxLines: 2,
            ),
          ),
          SizedBox(width: 10.w),
          SvgPicture.asset(AssetsPathHelper.filledRedirect),
        ],
      ),
    );
  }
}

class ProfileSwitchListCard extends StatelessWidget {
  final String title;
  final RxBool value;
  final Function() onChanged;

  const ProfileSwitchListCard({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _BaseSmallAppListCard(
        onPressed: onChanged,
        child: Row(
          children: [
            Expanded(
              child: ThemedText(
                title,
                themedTextStyle: ThemedTextStyle.body,
                maxLines: 2,
              ),
            ),
            SizedBox(width: 10.w),
            CupertinoSwitch(
              value: value.value,
              onChanged: (_) => onChanged(),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileSelectedListCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function() onPressed;

  const ProfileSelectedListCard({
  super.key,
  required this.title,
  required this.isSelected,
  required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return _BaseSmallAppListCard(
      onPressed: onPressed,
      child: Row(
        children: [
          Expanded(
            child: ThemedText(
              title,
              themedTextStyle: ThemedTextStyle.body,
              maxLines: 2,
            ),
          ),
          SizedBox(width: 10.w),
          if (isSelected)
            SvgPicture.asset(
              AssetsPathHelper.filledCheckmark,
              colorFilter: ColorFilter.mode(
                colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
        ],
      ),
    );
  }
}
