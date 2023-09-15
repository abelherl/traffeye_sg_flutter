import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/assets_path_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/style_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/app_ink_well.dart';
import 'package:traffeye_sg_flutter/2_application/widgets/themed_text.dart';
import 'package:traffeye_sg_flutter/theme.dart';

abstract class AppListCard {
  static Widget normal(
      {required Widget child,
      required Function() onPressed}) {
    return _NormalAppListCard(onPressed: onPressed, child: child);
  }

  static Widget profileBasic(
      {required String title,
      required Function() onPressed,
      String suffix = ''}) {
    return _ProfileBasicListCard(
        title: title, onPressed: onPressed, suffix: suffix);
  }
}

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

// * Card variants

class _NormalAppListCard extends StatelessWidget {
  final Widget child;
  final Function() onPressed;

  const _NormalAppListCard({
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseAppListCard(
      onPressed: onPressed,
      child: child,
    );
  }
}

class _ProfileBasicListCard extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final String suffix;

  const _ProfileBasicListCard({
    required this.title,
    required this.onPressed,
    this.suffix = '',
  });

  @override
  Widget build(BuildContext context) {
    return _BaseAppListCard(
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
