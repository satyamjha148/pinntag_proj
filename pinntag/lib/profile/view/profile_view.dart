import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinntag/core/controller/theme_controller.dart';

class ProfileScreen extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose Theme',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.light_mode),
                  const SizedBox(width: 8),
                  const Text('Light Mode'),
                  const Spacer(),
                  Switch(
                    value: themeController.isDarkMode.value,
                    onChanged: (_) => themeController.toggleTheme(),
                  ),
                  const Text('Dark Mode'),
                  const SizedBox(width: 8),
                  const Icon(Icons.dark_mode),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
