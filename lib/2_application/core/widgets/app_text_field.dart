import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/app_text_field_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/style_helper.dart';
import 'package:traffeye_sg_flutter/2_application/widgets/themed_text.dart';
import 'package:traffeye_sg_flutter/theme.dart';

class AppTextField extends StatelessWidget {
  final String? title;
  final String hint;
  final String initialText;
  final String? iconPath;
  final int? maxCharacter;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  const AppTextField({
    super.key,
    this.title,
    this.hint = '',
    this.initialText = '',
    this.iconPath,
    this.maxCharacter,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
        AppTextFieldController(currentLength: initialText.length.obs));
    final theme = Theme.of(context);
    final borderRadiusSmall = StyleHelper.borderRadiusSmall;
    final textController = TextEditingController(text: initialText);

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
          child: Obx(
            () => TextField(
              style: theme.textTheme.bodyLarge,
              textInputAction: textInputAction,
              maxLength: maxCharacter,
              controller: textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: borderRadiusSmall,
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.w,
                ),
                counter: Container(),
                filled: true,
                fillColor: Colors.white,
                hintText: hint,
                hintStyle: theme.textTheme.bodyLarge?.copyWith(
                  color: AppTheme.lightHintColor,
                ),
                suffix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 10.w),
                    ThemedText(
                      '${controller.currentLength.value}/$maxCharacter',
                      themedTextStyle: ThemedTextStyle.caption,
                      isMarkdown: false,
                    ),
                    if (iconPath != null)
                      SvgPicture.asset(
                        iconPath!,
                        height: 18.w,
                        width: 18.w,
                        fit: BoxFit.scaleDown,
                      ),
                  ],
                ),
              ),
              onChanged: (text) {
                controller.changeCurrentLengthTo(text.length);

                if (onChanged != null) {
                  onChanged!(text);
                }
              },
              onSubmitted: onSubmitted,
            ),
          ),
        ),
      ],
    );
  }
}
