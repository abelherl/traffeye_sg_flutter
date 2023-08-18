import 'package:get/get.dart';

enum DashboardLayout {
  carousel(name: 'Carousel'),
  grid(name: 'Grid'),
  list(name: 'List');

  const DashboardLayout({required this.name});

  final String name;
}

class AppController extends GetxController {
  final _isSavedCamerasActive = true.obs;
  final _isExploreCamerasActive = true.obs;
  final _isHomeWidgetsActive = true.obs;
  final _selectedDashboardLayout = DashboardLayout.carousel.obs;
  final currentIndex = 0.obs;

  void updateCurrentIndexTo(int index) => currentIndex.value = index;

  bool get isSavedCamerasActive => _isSavedCamerasActive.value;
  bool get isExploreCamerasActive => _isExploreCamerasActive.value;
  bool get isHomeWidgetsActive => _isHomeWidgetsActive.value;

  void toggleSavedCameras() => _isSavedCamerasActive.toggle();
  void toggleExploreCameras() => _isExploreCamerasActive.toggle();
  void toggleHomeWidgets() => _isHomeWidgetsActive.toggle();

  void changeDashboardLayoutTo(DashboardLayout dashboardLayout) {
    _selectedDashboardLayout.value = dashboardLayout;
  }
}