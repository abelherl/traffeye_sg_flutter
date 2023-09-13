import 'package:get/get.dart';

class BotNavController extends GetxController {
  final index = 0.obs;

  void changeIndexTo(int index) {
    this.index.value = index;
  }
}