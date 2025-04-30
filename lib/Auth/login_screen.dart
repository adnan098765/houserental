import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zillow_rental/AppColors/app_colors.dart';
import 'package:zillow_rental/bottom_nav_screen.dart';

import '../Controller/auth_controller.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Form(
          key: controller.loginFormKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Center(
                  child: Icon(Icons.home_work_rounded, size: 80, color: AppColors.purpleColor),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    'Welcome Back',
                    style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.purpleColor),
                  ),
                ),
                const SizedBox(height: 40),

                // Email Field
                TextFormField(
                  controller: controller.email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Email is required';
                    if (!val.contains('@')) return 'Enter a valid email';
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Password Field
                Obx(() => TextFormField(
                  controller: controller.password,
                  obscureText: !controller.isPasswordVisible.value,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(controller.isPasswordVisible.value ? Icons.visibility : Icons.visibility_off),
                      onPressed: controller.togglePassword,
                    ),
                  ),
                  validator: (val) => val == null || val.length < 6 ? 'Password must be at least 6 characters' : null,
                )),

                const SizedBox(height: 32),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.purpleColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      if (controller.loginFormKey.currentState!.validate()) {
                        controller.login();
                        Get.offAll(BottomNavScreen());// Your login logic
                      }
                    },
                    child: const Text('Login', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: AppColors.whiteTheme)),
                  ),
                ),

                const SizedBox(height: 20),

                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () => Get.to(() => const SignupScreen()),
                      child: Text('Sign up', style: TextStyle(color: AppColors.purpleColor)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
