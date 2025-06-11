import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinntag/auth/controller/login_controller.dart';
import 'package:pinntag/core/assets/base_assets.dart';
import 'package:pinntag/utils/common_button.dart';
import 'package:pinntag/utils/custom_textfield.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.05),

              Image.asset(
                BaseAssets.appLogo,
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 30),

              Text(
                "Hey there! Ready to get back to business?",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 12),

              Text(
                "Let's get you logged in and back to making\nthings happen.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).hintColor,
                ),
              ),

              const SizedBox(height: 40),

              CustomTextField(
                controller: controller.emailController,
                hintText: "Enter your email address",
                keyboardType: TextInputType.emailAddress,
                onChanged: (val) {},
              ),

              const SizedBox(height: 20),

              Obx(
                () => CustomTextField(
                  controller: controller.passwordController,
                  hintText: "Enter Password",
                  isPassword: true,
                  obscureText: controller.obscurePassword.value,
                  onSuffixTap: controller.togglePasswordVisibility,
                  onChanged: (val) {},
                ),
              ),

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forget Password?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              SizedBox(height: Get.height * 0.2),

              CommonButton(
                label: "Login",
                isEnabled: true,
                onPressed: controller.loginUser,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
