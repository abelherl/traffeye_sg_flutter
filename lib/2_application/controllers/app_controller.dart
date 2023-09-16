import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/keys_helper.dart';

enum DashboardLayout {
  carousel(name: 'Carousel'),
  grid(name: 'Grid'),
  list(name: 'List');

  const DashboardLayout({required this.name});

  final String name;

  static DashboardLayout fromString(String string) {
    switch (string) {
      case 'List':
        return DashboardLayout.list;
      case 'Grid':
        return DashboardLayout.grid;
      default:
        return DashboardLayout.carousel;
    }
  }
}

class AppController extends GetxController {
  final isSavedCamerasActive = true.obs;
  final isExploreCamerasActive = true.obs;
  final isHomeWidgetsActive = true.obs;
  final selectedDashboardLayout = DashboardLayout.carousel.obs;
  late final SharedPreferences _prefs;

  @override
  void onInit() {
    super.onInit();
    _onInit();
  }

  void changeDashboardLayoutTo(DashboardLayout dashboardLayout) {
    selectedDashboardLayout.value = dashboardLayout;
  }

  void toggleSavedCameras() {
    isSavedCamerasActive.toggle();
    _prefs.setBool(KeysHelper.isSavedCamerasActive, isSavedCamerasActive.value);
  }

  void toggleExploreCameras() {
    isExploreCamerasActive.toggle();
    _prefs.setBool(KeysHelper.isExploreCamerasActive, isExploreCamerasActive.value);
  }

  void toggleHomeWidgets() {
    isHomeWidgetsActive.toggle();
    _prefs.setBool(KeysHelper.isHomeWidgetsActive, isHomeWidgetsActive.value);
  }

  void _onInit() async {
    _prefs = await SharedPreferences.getInstance();
    isSavedCamerasActive.value =
        _prefs.getBool(KeysHelper.isSavedCamerasActive) ?? true;
    isExploreCamerasActive.value =
        _prefs.getBool(KeysHelper.isExploreCamerasActive) ?? true;
    isHomeWidgetsActive.value =
        _prefs.getBool(KeysHelper.isHomeWidgetsActive) ?? true;
    selectedDashboardLayout.value = DashboardLayout.fromString(
        _prefs.getString(KeysHelper.selectedDashboardLayout) ?? '');
  }
}
