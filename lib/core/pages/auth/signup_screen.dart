import 'package:flutter/material.dart';
import 'package:oncoguide_frontend/core/conts/colors.dart';
import 'package:oncoguide_frontend/core/widgets/app_text_feild.dart';
import '../../widgets/primary_button.dart';
import '../../utils/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUpDoctor({
    required String name,
    required String email,
    required String password,
  }) async {
    // 1. Create user in Firebase Auth
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = userCredential.user!.uid;

    // 2. Store doctor data in Firestore
    await _firestore.collection('doctors').doc(uid).set({
      'uid': uid,
      'name': name,
      'email': email,
      'role': 'doctor',
      'createdAt': FieldValue.serverTimestamp(),
      'isActive': true,
    });
  }
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isLoading = false;

  final AuthService _authService = AuthService();

  void handleSignUp() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("All fields are required")));
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords do not match")));
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await _authService.signUpDoctor(
        name: name,
        email: email,
        password: password,
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Sign up successful!")));

      Navigator.pop(context); // Go back to login page
    } on FirebaseAuthException catch (e) {
      String message = "An error occurred";
      if (e.code == 'email-already-in-use') {
        message = "Email is already in use";
      } else if (e.code == 'weak-password') {
        message = "Password is too weak";
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Something went wrong")));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

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
                        text: isLoading ? "Signing Up..." : "Sign Up",
                        onPressed: isLoading ? null : handleSignUp,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Redirect to Login
                    Animations.fadeIn(
                      delay: 1100,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
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
