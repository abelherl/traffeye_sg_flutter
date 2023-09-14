import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/saved_cameras_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/warning_widget.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/saved_cameras/widgets/saved_camera_list_item.dart';

class SavedCamerasPage extends StatelessWidget {
  const SavedCamerasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SavedCamerasController());

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(IntlHelper.savedCameras.tr),
          centerTitle: true,
        ),
        body: Container(
          height: double.infinity,
          color: colorScheme.background,
          child: controller.savedCameras.isEmpty
              ? WarningWidget(
                  title: IntlHelper.errorNoSavedCamerasTitle.tr,
                  subtitle: IntlHelper.errorNoSavedCamerasSubtitle.tr,
                )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: DragAndDropLists(
                    itemDragOnLongPress: false,
                    disableScrolling: true,
                    children: [
                      DragAndDropList(
                        canDrag: false,
                        children: controller.savedCameras.map((camera) {
                          return DragAndDropItem(
                            child: SavedCameraListItem(camera: camera),
                          );
                        }).toList(),
                      ),
                    ],
                    onItemReorder: controller.reorder,
                    onListReorder: (_, __) {},
                  ),
                ),
        ),
      ),
    );
  }
}
