import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffeye_sg_flutter/2_application/widgets/themed_text.dart';

class ProfileSection extends StatelessWidget {
  final String title;
  final List<Widget> appListCards;

  const ProfileSection({
    super.key,
    required this.title,
    required this.appListCards,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16.w).copyWith(bottom: 0),
          child: ThemedText(
            title,
            themedTextStyle: ThemedTextStyle.title,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        ...appListCards,
      ],
    );
  }
}
