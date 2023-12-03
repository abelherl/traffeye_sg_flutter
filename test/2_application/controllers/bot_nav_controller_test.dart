import 'package:get/get.dart';
import 'package:test/test.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/bot_nav_controller.dart';

void main() {
  group('BotNavController', () {
    final controller = BotNavController();
    Get.put<BotNavController>(controller);

    group('changeIndexTo() should change the value properly', () {
      test('when called', () async {
        const matcher = 3;
        controller.changeIndexTo(matcher);
        expect(controller.index.value, matcher);
      });
    });
  });
}
