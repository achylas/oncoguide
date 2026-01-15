import 'package:flutter/material.dart';
import 'package:oncoguide_frontend/core/conts/colors.dart';
import 'package:oncoguide_frontend/core/widgets/app_text_feild.dart';
import '../../widgets/primary_button.dart';
import '../../utils/animations.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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

          // Floating decorative shapes
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

          // Signup Card
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Animations.fadeIn(
                      delay: 300,
                      child: const Text(
                        "Create Account",
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
                        "Sign up to get started",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Name
                    Animations.slideUp(
                      delay: 600,
                      child: AppTextField(
                        hintText: "Full Name",
                        controller: nameController,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Email
                    Animations.slideUp(
                      delay: 700,
                      child: AppTextField(
                        hintText: "Email",
                        controller: emailController,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Password
                    Animations.slideUp(
                      delay: 800,
                      child: AppTextField(
                        hintText: "Password",
                        controller: passwordController,
                        isPassword: true,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Confirm Password
                    Animations.slideUp(
                      delay: 900,
                      child: AppTextField(
                        hintText: "Confirm Password",
                        controller: confirmPasswordController,
                        isPassword: true,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Signup Button
                    Animations.slideUp(
                      delay: 1000,
                      child: PrimaryButton(
                        text: "Sign Up",
                        onPressed: () {
                          // Add signup logic here
                          print("Name: ${nameController.text}");
                          print("Email: ${emailController.text}");
                          print("Password: ${passwordController.text}");
                          print("Confirm: ${confirmPasswordController.text}");
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Redirect to Login
                    Animations.fadeIn(
                      delay: 1100,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Go back to login page
                        },
                        child: const Text(
                          "Already have an account? Login",
                          style: TextStyle(color: AppColors.accent),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
