import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinntag/auth/controller/splash_controller.dart';
import 'package:pinntag/core/assets/base_assets.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(body: Center(child: Image.asset(BaseAssets.appLogo)));
  }
}
