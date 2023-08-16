import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:traffeye_sg_flutter/0_datasource/datasources/traffic_camera_datasource.dart';
import 'package:traffeye_sg_flutter/0_datasource/repositories/traffic_camera_repository_impl.dart';
import 'package:traffeye_sg_flutter/1_domain/repositories/traffic_camera_repository.dart';
import 'package:traffeye_sg_flutter/1_domain/usecases/traffic_camera_usecases.dart';
import 'package:traffeye_sg_flutter/2_application/core/intl/intl_en_us.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>> translationsKeys = {
    "en_US": enUS,
  };
}

final Map<String, String> enUS = IntlEnUs.translations;
