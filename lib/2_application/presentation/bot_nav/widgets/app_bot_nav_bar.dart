import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/assets_path_helper.dart';

class AppBotNavBar extends StatelessWidget {
  final Function(int index) onTap;
  const AppBotNavBar({
    Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DotNavigationBar(
      backgroundColor: theme.colorScheme.primary,
      dotIndicatorColor: theme.colorScheme.tertiary,
      enableFloatingNavBar: true,
      splashColor: Colors.transparent,
      onTap: (index) => onTap(index),
      marginR: EdgeInsets.symmetric(vertical: 18.w, horizontal: 50.w),
      paddingR: EdgeInsets.symmetric(vertical: 6.w, horizontal: 16.w),
      itemPadding: EdgeInsets.fromLTRB(16.w, 10.w, 16.w, 13.w),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          offset: Offset(0, 3),
          blurRadius: 12,
          spreadRadius: 2,
        )
      ],
      borderRadius: 160.r,
      items: [
        DotNavigationBarItem(
            icon: SvgPicture.asset(AssetsPathHelper.filledHome)),
        DotNavigationBarItem(
            icon: SvgPicture.asset(AssetsPathHelper.filledBookmark)),
        DotNavigationBarItem(
            icon: SvgPicture.asset(AssetsPathHelper.filledProfile)),
      ],
    );
  }
}
