import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/saved_cameras_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/assets_path_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/warning_widget.dart';

class SavedCamerasPage extends StatelessWidget {
  const SavedCamerasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SavedCamerasController());

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(IntlHelper.savedCameras.tr),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset(AssetsPathHelper.filledEdit),
            onPressed: controller.isEditingToggle,
          ),
        ],
      ),
      body: Container(
        color: colorScheme.background,
        child: Obx(
          () => controller.savedCameras.isEmpty
              ? WarningWidget(
                  title: IntlHelper.errorNoSavedCamerasTitle.tr,
                  subtitle: IntlHelper.errorNoSavedCamerasSubtitle.tr,
                )
              : DragAndDropLists(
                  children: [
                    DragAndDropList(
                      children: controller.savedCameras.map((camera) {
                        return DragAndDropItem(
                          child: Text(camera.getName()),
                        );
                      }).toList(),
                    ),
                  ],
                  onItemReorder: controller.reorder,
                  onListReorder: (_, __) {},
                ),
        ),
      ),
    );
  }
}
