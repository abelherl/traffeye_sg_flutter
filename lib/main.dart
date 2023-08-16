import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/splash/splash_screen_page.dart';
import 'package:traffeye_sg_flutter/injection.dart';
import 'package:traffeye_sg_flutter/theme.dart';
import 'package:traffeye_sg_flutter/translation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
              locale: Get.deviceLocale,
              home: const SplashScreenPage(),
            );
          },
        ),
      ),
    );
  }
}
