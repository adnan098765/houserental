import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zillow_rental/Auth/signup_screen.dart';
import '../Auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();

    Future.delayed(const Duration(seconds: 4), () {
      Get.off(() => const SignupScreen());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage("assets/images/image.png")),

            const SizedBox(height: 20),

            FadeTransition(
              opacity: _fadeAnimation,
              child: Text(
                "Find Your Perfect Home",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade800,
                ),
              ),
            ),

            const SizedBox(height: 10),
            FadeTransition(
              opacity: _fadeAnimation,
              child: Text(
                "Rent. Relax. Repeat.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.teal.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
