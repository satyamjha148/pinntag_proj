import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinntag/home/controller/bottom_bar_controller.dart';
import 'package:pinntag/home/controller/home_controller.dart';
import 'package:pinntag/home/view/home_view.dart';

class BottomNavBarView extends StatelessWidget {
  final String? title;
  BottomNavBarView({super.key, required this.title});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeView(title: title ?? ""), // Home
      SizedBox(), // Locations
      SizedBox(), // Content
      SizedBox(), // Rewards
      SizedBox(), // Users
    ];
    return GetBuilder<BottomNavController>(
      init: BottomNavController(),
      builder: (controller) {
        return Scaffold(
          extendBody: true,
          body: pages[controller.currentIndex],
          bottomNavigationBar: Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(28),
            ),
            child: BottomNavigationBar(
              currentIndex: controller.currentIndex,
              onTap: controller.onTabChanged,
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.teal,
              unselectedItemColor: Colors.white70,
              elevation: 0,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              showUnselectedLabels: true,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.location_on_outlined),
                  label: 'Locations',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_customize_outlined),
                  label: 'Content',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.card_giftcard),
                  label: 'Rewards',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  label: 'Users',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
