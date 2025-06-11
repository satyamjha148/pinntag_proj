import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinntag/auth/view/login_view.dart';
import 'package:pinntag/auth/view/splash_screen.dart';
import 'package:pinntag/core/controller/theme_controller.dart';
import 'package:pinntag/core/theme/app_theme.dart';
import 'package:pinntag/home/view/dashboard_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool('isDarkMode') ?? false;

  final ThemeController themeController = Get.put(ThemeController());
  themeController.isDarkMode.value = isDark;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return Obx(() {
      return GetMaterialApp(
        title: 'PinnTag',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode:
            themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(name: '/', page: () => const SplashView()),
          GetPage(name: '/login', page: () => const LoginView()),
          GetPage(name: '/dashBorad', page: () => DashboardView()),
        ],
        home: const SplashView(),
      );
    });
  }
}
