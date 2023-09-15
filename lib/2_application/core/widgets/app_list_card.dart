import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/style_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/app_ink_well.dart';

abstract class AppListCard {
  static Widget normal({required Widget child, required Function() onPressed}) {
    return _NormalAppListCard(onPressed: onPressed, child: child);
  }
}

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
