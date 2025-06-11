import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinntag/utils/custom_alert.dart';
import 'package:pinntag/utils/loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  RxInt totalImpressions = 352.obs;
  RxInt userEngagement = 124.obs;
  RxInt totalRedemptions = 43.obs;
  RxInt activeParticipants = 13.obs;

  RxDouble setupCompletion = 95.0.obs;

  List<Map<String, dynamic>> get stats => [
    {
      'title': 'Total Impressions',
      'value': totalImpressions.value,
      'icon': Icons.remove_red_eye_outlined,
    },
    {
      'title': 'User Engagement',
      'value': userEngagement.value,
      'icon': Icons.favorite_outline,
    },
    {
      'title': 'Total Redemptions',
      'value': totalRedemptions.value,
      'icon': Icons.card_giftcard_outlined,
    },
    {
      'title': 'Active Participants',
      'value': activeParticipants.value,
      'icon': Icons.groups_2_outlined,
    },
  ];

  void logoutUser() {
    CommonAlertDialog.showWithCancelAndOkay(
      content: 'Do you want to logout ?',
      onOkPressed: () async {
        AppLoader.show();
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          await prefs.remove('token');
          await prefs.remove('user');
          Get.offAllNamed('/login');
        } catch (e) {
          CommonAlertDialog.showWithOkay(content: e.toString());
        } finally {
          AppLoader.hide();
        }
      },
      cancelText: 'No',
      okText: 'Yes',
    );
  }
}
