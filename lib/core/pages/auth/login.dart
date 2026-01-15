import 'package:flutter/material.dart';
import 'package:oncoguide_frontend/core/pages/auth/signup_screen.dart';
import 'package:oncoguide_frontend/core/widgets/app_text_feild.dart';
import '../../conts/colors.dart';
import '../../widgets/primary_button.dart';
import '../../utils/animations.dart';

import '../dashboard/dashboard_screen.dart'; // <- Import Dashboard

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFF0F3), Color(0xFFFFC1CC)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Decorative circles
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -60,
            right: -40,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Centered login card
          Center(
            child: Container(
              width: size.width * 0.85,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  Animations.fadeIn(
                    delay: 300,
                    child: const Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Animations.fadeIn(
                    delay: 450,
                    child: const Text(
                      "Sign in to continue",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Email Field
                  Animations.slideUp(
                    delay: 600,
                    child: AppTextField(
                      hintText: "Email",
                      controller: emailController,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Password Field
                  Animations.slideUp(
                    delay: 700,
                    child: AppTextField(
                      hintText: "Password",
                      controller: passwordController,
                      isPassword: true,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Login Button -> Navigate to Dashboard
                  Animations.slideUp(
                    delay: 800,
                    child: PrimaryButton(
                      text: "Login",
                      onPressed: () {
                        // Here, navigate to DashboardScreen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DashboardScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Forgot password
                  Animations.fadeIn(
                    delay: 900,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: AppColors.accent),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Signup Option
                  Animations.fadeIn(
                    delay: 1000,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: AppColors.accent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
