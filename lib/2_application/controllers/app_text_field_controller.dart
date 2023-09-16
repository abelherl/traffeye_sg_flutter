import 'package:get/get.dart';

class AppTextFieldController extends GetxController {
  final RxInt currentLength;

  AppTextFieldController({required this.currentLength});

  void changeCurrentLengthTo(int currentLength) {
    this.currentLength.value = currentLength;
  }
}