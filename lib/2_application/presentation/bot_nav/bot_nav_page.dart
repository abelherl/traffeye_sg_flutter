import 'package:flutter/material.dart';
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
      body: const FadeIndexedStack(
        index: 0,
        children: [
          DashboardPage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () => Get.find<CameraController>().updateSnapshots(),
        child: SvgPicture.asset(AssetsPathHelper.filledRefresh),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 12,
              spreadRadius: 2,
            )
          ]
        ),
        child: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.onPrimary,
          fixedColor: Theme.of(context).colorScheme.onPrimary,
          items: [
            BottomNavigationBarItem(icon: SvgPicture.asset(AssetsPathHelper.filledHome), label: ''),
            BottomNavigationBarItem(icon: SvgPicture.asset(AssetsPathHelper.filledBookmark), label: ''),
            BottomNavigationBarItem(icon: SvgPicture.asset(AssetsPathHelper.filledProfile), label: ''),
          ],
        ),
      ),
    );
  }
}
