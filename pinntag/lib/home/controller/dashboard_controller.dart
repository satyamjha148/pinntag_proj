import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinntag/home/repo/home_repo.dart';
import 'package:pinntag/home/view/bottom_bar.dart';
import 'package:pinntag/utils/custom_alert.dart';
import 'package:pinntag/utils/loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController {
  final HomeRepo homeRepo = Get.put(HomeRepo());

  void switchBusiness(String id, String title) async {
    AppLoader.show();
    try {
      final response = await homeRepo.switchBusinessApi(id);

      if (response.token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.token!);

        AppLoader.hide();
        debugPrint("Title is $title");

        AppLoader.hide();

        Get.offAll(() => BottomNavBarView(title: title));
      } else {
        CommonAlertDialog.showWithOkay(
          content: response.message ?? "Switch failed.",
        );
      }
    } catch (e) {
      AppLoader.hide();
      CommonAlertDialog.showWithOkay(
        content: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }
}
