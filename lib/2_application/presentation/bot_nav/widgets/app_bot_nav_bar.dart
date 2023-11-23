import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/bot_nav_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/assets_path_helper.dart';

class AppBotNavBar extends StatelessWidget {
  final Function(int index) onTap;
  const AppBotNavBar({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BotNavController>();
    final theme = Theme.of(context);

    final icons = [
      AssetsPathHelper.filledHome,
      AssetsPathHelper.filledBookmark,
      AssetsPathHelper.filledProfile,
    ];

    return Padding(
      padding: EdgeInsets.only(bottom: 28.w),
      child: Obx(
        () => DotNavigationBar(
          currentIndex: controller.index.value,
          backgroundColor: theme.colorScheme.primary,
          dotIndicatorColor: theme.colorScheme.tertiary,
          splashColor: Colors.transparent,
          onTap: (index) => onTap(index),
          marginR: EdgeInsets.symmetric(vertical: 18.w, horizontal: 50.w),
          paddingR: EdgeInsets.symmetric(vertical: 6.w, horizontal: 16.w),
          itemPadding: EdgeInsets.fromLTRB(16.w, 10.w, 16.w, 13.w),
          enablePaddingAnimation: false,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 3),
              blurRadius: 12,
              spreadRadius: 2,
            )
          ],
          borderRadius: 160.r,
          items: icons.map(
            (icon) => DotNavigationBarItem(
              icon: SvgPicture.asset(icon),
            ),
          ).toList(),
        ),
      ),
    );
  }
}
