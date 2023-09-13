import 'package:get/get.dart';

class BotNavController extends GetxController {
  final index = 0.obs;

  void changeIndexTo(int index) {
    print("oneaofj");
    this.index.value = index;
  }
}