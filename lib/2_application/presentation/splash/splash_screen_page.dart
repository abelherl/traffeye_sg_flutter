import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/assets_path_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/home/home_page.dart';
import 'package:traffeye_sg_flutter/2_application/widgets/themed_text.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  @override
  void initState() {
    super.initState();
    _goToHomePage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _GradientBase(
        child: _GradientOverlay(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'logo',
                        child: SvgPicture.asset(
                          AssetsPathHelper.filledLogo,
                        ),
                      ),
                      SizedBox(height: 4.w),
                      ThemedText(
                        IntlHelper.splashCaption.tr,
                        themedTextStyle: ThemedTextStyle.caption,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AssetsPathHelper.imagesFlutter,
                      width: 85.w,
                    ),
                    SizedBox(width: 50.w),
                    SizedBox(
                      width: 70.w,
                      height: 35.w,
                      child: Image.asset(
                        AssetsPathHelper.imagesPngAbelHerl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.w),
            ],
          ),
        ),
      ),
    );
  }

  void _goToHomePage(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              transitionDuration: const Duration(seconds: 1),
              pageBuilder: (_, __, ___) => const HomePage()));
    });
  }
}

class _GradientBase extends StatelessWidget {
  final Widget child;

  const _GradientBase({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [colorScheme.primary, colorScheme.primaryContainer],
          center: Alignment.topRight,
          radius: 2,
        ),
      ),
      child: child,
    );
  }
}

class _GradientOverlay extends StatelessWidget {
  final Widget child;

  const _GradientOverlay({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.transparent, Colors.black45],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}
