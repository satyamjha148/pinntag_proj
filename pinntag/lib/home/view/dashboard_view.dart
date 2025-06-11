import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pinntag/home/controller/dashboard_controller.dart';
import 'package:pinntag/home/model/home_bussiness.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});
  final DashboardController homeController = Get.put(DashboardController());
  Future<List<HomeBusinessModel>> _fetchBusinessList() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');

    if (userJson == null) return [];

    final userMap = jsonDecode(userJson);
    final businessList = userMap['business'] as List<dynamic>?;

    if (businessList == null) return [];

    debugPrint("Bussines data id $businessList");

    return businessList
        .map((e) => HomeBusinessModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: FutureBuilder<List<HomeBusinessModel>>(
          future: _fetchBusinessList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No businesses found."));
            }

            final businesses = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    "Which business are we working on?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: GridView.builder(
                      itemCount: businesses.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 9,
                            childAspectRatio: 1.4,
                          ),
                      itemBuilder: (context, index) {
                        final business = businesses[index];
                        return GestureDetector(
                          onTap: () async {
                            if (business.name != null) {
                              homeController.switchBusiness(
                                business.id ?? "",
                                business.name ?? "N/A",
                              );
                            }
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child:
                                    business.logo != null
                                        ? Image.network(
                                          business.logo!,
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.cover,
                                        )
                                        : Container(
                                          height: 80,
                                          width: 80,
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            color: Colors.grey.shade400,
                                          ),
                                          child: Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              color: Colors.teal,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: const Icon(
                                              Icons.work_outline,
                                              size: 40,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                business.name ?? "N/A",
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 14),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
