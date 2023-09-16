import 'package:get/get.dart';

enum DashboardLayout {
  carousel(name: 'Carousel'),
  grid(name: 'Grid'),
  list(name: 'List');

  const DashboardLayout({required this.name});

  final String name;
}

class AppController extends GetxController {
  final isSavedCamerasActive = true.obs;
  final isExploreCamerasActive = true.obs;
  final isHomeWidgetsActive = true.obs;
  final selectedDashboardLayout = DashboardLayout.carousel.obs;

  void changeDashboardLayoutTo(DashboardLayout dashboardLayout) {
    selectedDashboardLayout.value = dashboardLayout;
  }
}