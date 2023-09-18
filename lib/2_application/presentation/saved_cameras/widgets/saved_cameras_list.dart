import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/saved_cameras_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/app_list_card.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/app_scroll_view.dart';

class SavedCamerasList extends StatelessWidget {
  const SavedCamerasList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SavedCamerasController>();
    return Obx(
      () => AppScrollView(
        child: DragAndDropLists(
          itemDragOnLongPress: false,
          disableScrolling: true,
          lastItemTargetHeight: 100.w,
          children: [
            DragAndDropList(
              canDrag: false,
              children: controller.savedCameras.map((camera) {
                return DragAndDropItem(
                  child: CameraAppListCard(camera: camera),
                );
              }).toList(),
            ),
          ],
          onItemReorder: controller.reorder,
          onListReorder: (_, __) {},
        ),
      ),
    );
  }
}
