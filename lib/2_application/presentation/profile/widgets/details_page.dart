import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/app_list_card.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/app_scroll_view.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/themed_app_bar.dart';
import 'package:traffeye_sg_flutter/2_application/widgets/themed_text.dart';

class DetailsPage extends StatelessWidget {
  final String pageTitle;
  final String title;
  final String description;
  final List<AppListCard>? cards;

  const DetailsPage(
      {super.key,
      required this.pageTitle,
      required this.title,
      required this.description,
      this.cards});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemedAppBar(
        title: pageTitle,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: AppScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ThemedText(
                    title,
                    themedTextStyle: ThemedTextStyle.title,
                  ),
                  SizedBox(height: 10.w),
                  ThemedText(
                    description,
                    themedTextStyle: ThemedTextStyle.body,
                  ),
                ],
              ),
            ),
            ...?cards,
          ],
        ),
      ),
    );
  }
}
