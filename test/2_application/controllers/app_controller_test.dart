import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/app_controller.dart';

void main() {
  group('AppController', () {
    SharedPreferences.setMockInitialValues({});
    final controller = AppController();

    group('onInit() should initiate valid values', () {
      test('when prefs are empty', () async {
        Get.put<AppController>(controller);
        expect(controller.isSavedCamerasActive.value, true);
        expect(controller.isExploreCamerasActive.value, true);
        expect(controller.isHomeWidgetsActive.value, true);
        expect(
            controller.selectedDashboardLayout.value, DashboardLayout.carousel);
      });
    });

    group('toggle functions should correctly change their values', () {
      test('when calling changeDashboardLayoutTo()', () {
        const layout = DashboardLayout.grid;
        controller.changeDashboardLayoutTo(layout);

        expect(controller.selectedDashboardLayout.value, layout);
      });

      test('when calling toggleSavedCameras()', () {
        final matcher = !controller.isSavedCamerasActive.value;
        controller.toggleSavedCameras();

        expect(controller.isSavedCamerasActive.value, matcher);
      });

      test('when calling toggleExploreCameras()', () {
        final matcher = !controller.isExploreCamerasActive.value;
        controller.toggleExploreCameras();

        expect(controller.isExploreCamerasActive.value, matcher);
      });

      test('when calling toggleHomeWidgets()', () {
        final matcher = !controller.isHomeWidgetsActive.value;
        controller.toggleHomeWidgets();

        expect(controller.isHomeWidgetsActive.value, matcher);
      });
    });
  });
}
