import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/explore_cameras/widgets/search_body.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/explore_cameras/widgets/search_header.dart';

class SearchCameraBottomSheet extends StatelessWidget {
  final bool isPreview;

  const SearchCameraBottomSheet({super.key, this.isPreview = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final radius = isPreview ? 16.r : 0.0;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        ),
      ),
      child: const Column(
        children: [
          SearchHeader(),
          SearchBody(),
        ],
      ),
    );
  }
}
