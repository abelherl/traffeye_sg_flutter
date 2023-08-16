import 'package:traffeye_sg_flutter/2_application/core/intl/intl_en_us.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>> translationsKeys = {
    "en_US": enUS,
  };
}

final Map<String, String> enUS = IntlEnUs.translations;
