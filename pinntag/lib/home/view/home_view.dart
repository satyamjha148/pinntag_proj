// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinntag/home/controller/home_controller.dart';
import 'package:pinntag/profile/view/profile_view.dart';

class HomeView extends StatelessWidget {
  final String title;
  HomeView({super.key, required this.title});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Obx(
      () => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          elevation: 0,
          title: Row(
            children: [
              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).appBarTheme.foregroundColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(width: 30),
              Icon(
                Icons.arrow_circle_down_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () {
                controller.logoutUser();
              },
              child: Icon(
                Icons.logout,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                Get.to(() => ProfileScreen());
              },
              child: CircleAvatar(
                radius: 15,
                backgroundColor: colorScheme.secondary,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor.withOpacity(0.4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children:
                      controller.stats.map((stat) {
                        return SizedBox(
                          width: (MediaQuery.of(context).size.width - 70) / 2,
                          height:
                              ((MediaQuery.of(context).size.width) / 2) / 1.5,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  stat['title'],
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary.withOpacity(0.7),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  stat['value'].toString(),
                                  style: textTheme.bodyLarge?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey.shade800
                        : const Color(0xFFF5F5F0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0.0, end: 0.95),
                            duration: const Duration(seconds: 2),
                            curve: Curves.easeOutCubic,
                            builder: (context, value, child) {
                              return CircularProgressIndicator(
                                value: value,
                                strokeWidth: 4,
                                color: Theme.of(context).colorScheme.secondary,
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.secondary.withOpacity(0.2),
                              );
                            },
                          ),
                        ),

                        Positioned.fill(
                          child: Center(
                            child: Text(
                              '95%',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Let's complete the setup of your business",
                          style: textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Please add the description to your business details.",
                          style: textTheme.bodySmall?.copyWith(
                            fontSize: 10,
                            color: Theme.of(
                              context,
                            ).textTheme.bodySmall?.color?.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.close,
                    size: 18,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.6),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: colorScheme.secondary.withOpacity(0.2),
                ),
              ),
              child: Image.network(
                'https://miro.medium.com/v2/resize:fit:1400/format:webp/1*8ZGC79f70ZpDbwrhYha-xA.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
