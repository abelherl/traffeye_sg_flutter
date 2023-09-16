import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/saved_cameras_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/themed_app_bar.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/warning_widget.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/saved_cameras/widgets/saved_cameras_list.dart';

class SavedCamerasPage extends StatelessWidget {
  const SavedCamerasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SavedCamerasController());

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Obx(
      () => Scaffold(
        appBar: ThemedAppBar(
          title: IntlHelper.savedCameras.tr,
          enableBackButton: false,
        ),
        body: Container(
          height: double.infinity,
          color: colorScheme.background,
          child: controller.savedCameras.isEmpty
              ? WarningWidget(
                  title: IntlHelper.errorNoSavedCamerasTitle.tr,
                  subtitle: IntlHelper.errorNoSavedCamerasSubtitle.tr,
                )
              : const SavedCamerasList(),
        ),
      ),
    );
  }
}
