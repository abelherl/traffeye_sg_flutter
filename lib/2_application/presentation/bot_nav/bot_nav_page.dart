import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/camera_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/assets_path_helper.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/bot_nav/widgets/fade_indexed_stack.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/dashboard/dashboard_page.dart';

class BotNavPage extends StatelessWidget {
  const BotNavPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: const FadeIndexedStack(
        index: 0,
        children: [
          DashboardPage(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 32.w),
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () => Get.find<CameraController>().updateSnapshots(),
          child: SvgPicture.asset(AssetsPathHelper.filledRefresh),
        ),
      ),
      bottomNavigationBar: DotNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        dotIndicatorColor: Theme.of(context).colorScheme.tertiary,
        enableFloatingNavBar: true,
        splashColor: Colors.transparent,
        onTap: (_) => print('cok'),
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
      ),
    );
  }
}
