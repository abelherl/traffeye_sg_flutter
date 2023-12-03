import 'package:get/get.dart';
import 'package:test/test.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/app_text_field_controller.dart';

void main() {
  group('AppTextFieldController', () {
    final controller = AppTextFieldController(currentLength: 0.obs);
    Get.put<AppTextFieldController>(controller);

    group('changeCurrentLengthTo() should change the value properly', () {
      test('when called', () async {
        const matcher = 10;
        controller.changeCurrentLengthTo(matcher);
        expect(controller.currentLength.value, matcher);
      });
    });
  });
}
