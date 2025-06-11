import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinntag/auth/repo/login_repo.dart';
import 'package:pinntag/home/view/dashboard_view.dart';
import 'package:pinntag/utils/custom_alert.dart';
import 'package:pinntag/utils/loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final LoginRepo loginRepo = Get.put(LoginRepo());

  RxBool obscurePassword = true.obs;
  RxBool isLoginEnabled = false.obs;

  @override
  void onInit() {
    super.onInit();

    emailController.addListener(validateFields);
    passwordController.addListener(validateFields);
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void validateFields() {
    final email = emailController.text.trim();
    final password = passwordController.text;
    isLoginEnabled.value =
        email.isNotEmpty && password.isNotEmpty && password.length >= 6;
  }

  void loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty) {
      CommonAlertDialog.showWithOkay(content: "Please enter your email.");
      return;
    }
    if (!email.contains('@')) {
      CommonAlertDialog.showWithOkay(
        content: "Please enter a valid email address.",
      );
      return;
    }
    if (password.isEmpty) {
      CommonAlertDialog.showWithOkay(content: "Please enter your password.");
      return;
    }
    if (password.length < 6) {
      CommonAlertDialog.showWithOkay(
        content: "Password must be at least 6 characters.",
      );
      return;
    }

    AppLoader.show();

    try {
      final response = await loginRepo.loginUserApi(email, password);

      if (response.token != null && response.user != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.token!);
        await prefs.setString('user', jsonEncode(response.user!.toJson()));

        debugPrint("Login successful");
        Get.offAll(DashboardView());
      } else {
        AppLoader.hide();
        CommonAlertDialog.showWithOkay(
          content: response.message ?? "Login failed.",
        );
      }
    } catch (e) {
      AppLoader.hide();
      debugPrint("Login error: $e");
      CommonAlertDialog.showWithOkay(
        content: e.toString().replaceAll("Exception:", "").trim(),
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
