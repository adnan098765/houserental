import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isPasswordVisible = false.obs;

  void togglePassword() => isPasswordVisible.value = !isPasswordVisible.value;

  final loginFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();

  // Example data
  final email = TextEditingController();
  final password = TextEditingController();

  void login() {
    if (loginFormKey.currentState!.validate()) {
      Get.snackbar("Login", "Logged in successfully");
    }
  }

  void signup() {
    if (signupFormKey.currentState!.validate()) {
      Get.snackbar("Signup", "Account created successfully");
    }
  }
}
