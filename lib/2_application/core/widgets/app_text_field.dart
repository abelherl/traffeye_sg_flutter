import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:traffeye_sg_flutter/2_application/widgets/themed_text.dart';
import 'package:traffeye_sg_flutter/theme.dart';

class AppTextField extends StatelessWidget {
  final String? title;
  final String hint;
  final String iconPath;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  const AppTextField({
    super.key,
    this.title,
    this.hint = '',
    this.iconPath = '',
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderRadiusSmall = BorderRadius.circular(8.r);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          ThemedText(
            title!,
            themedTextStyle: ThemedTextStyle.label,
          ),
        SizedBox(height: 8.w),
        Container(
          decoration: BoxDecoration(
            borderRadius: borderRadiusSmall,
            boxShadow: [
              BoxShadow(
                blurRadius: 8.w,
                offset: Offset(0, 2.w),
                color: Colors.black12,
              )
            ],
          ),
          child: TextField(
            style: theme.textTheme.bodyLarge,
            textInputAction: textInputAction,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: borderRadiusSmall,
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.w,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              hintStyle: theme.textTheme.bodyLarge?.copyWith(
                color: AppTheme.lightHintColor,
              ),
              suffixIcon: SvgPicture.asset(
                iconPath,
                height: 18.w,
                width: 18.w,
                fit: BoxFit.scaleDown,
              ),
            ),
            onChanged: onChanged,
            onSubmitted: onSubmitted,
          ),
        ),
      ],
    );
  }
}
