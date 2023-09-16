import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/assets_path_helper.dart';

class ThemedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool enableBackButton;

  const ThemedAppBar(
      {super.key, required this.title, this.enableBackButton = true});

  @override
  final Size preferredSize = const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: enableBackButton
          ? IconButton(
              icon: SvgPicture.asset(AssetsPathHelper.filledBack),
              onPressed: () => Get.back(),
            )
          : null,
    );
  }
}
