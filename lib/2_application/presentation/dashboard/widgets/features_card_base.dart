import 'package:flutter/material.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/style_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/app_ink_well.dart';

class FeaturesCardBase extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final Function() onPressed;

  const FeaturesCardBase({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AspectRatio(
      aspectRatio: StyleHelper.ratioCarousel,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: StyleHelper.borderRadiusBig,
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.fill,
          ),
        ),
        child: AppInkWell(
          onPressed: () => onPressed(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                style: theme.textTheme.displayLarge?.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              Text(
                subtitle,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
