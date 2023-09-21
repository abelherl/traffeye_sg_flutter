import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/location_entity.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/box_tags_helper.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/splash/splash_screen_page.dart';
import 'package:traffeye_sg_flutter/injection.dart';
import 'package:traffeye_sg_flutter/theme.dart';
import 'package:traffeye_sg_flutter/translation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Hive
    ..init((await getApplicationDocumentsDirectory()).path)
    ..registerAdapter(TrafficCameraAdapter())
    ..registerAdapter(LocationAdapter());
  await Hive.openBox<TrafficCameraEntity>(BoxTagsHelper.cameras);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: DevicePreview(
        enabled: false,
        builder: (_) => ScreenUtilInit(
          designSize: Size(size.width, size.height),
          builder: (_, __) {
            return GetMaterialApp(
              initialBinding: AppInjections(),
              title: 'Flutter Demo',
              theme: AppTheme.lightTheme,
              debugShowCheckedModeBanner: false,
              translationsKeys: AppTranslation.translationsKeys,
              locale: const Locale('en', 'US'),
              fallbackLocale: const Locale('en', 'US'),
              home: const SplashScreenPage(),
            );
          },
        ),
      ),
    );
  }
}
