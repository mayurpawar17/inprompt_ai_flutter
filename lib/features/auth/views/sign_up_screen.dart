import 'package:flutter/material.dart';

import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                Text(
                  "Create Account ✨",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  "Join us and start your journey",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const SizedBox(height: 32),

                AppTextField(
                  label: "Full Name",
                  icon: Icons.person_outline,
                  controller: nameController,
                ),
                const SizedBox(height: 16),

                AppTextField(
                  label: "Email",
                  icon: Icons.email_outlined,
                  controller: emailController,
                ),
                const SizedBox(height: 16),

                AppTextField(
                  label: "Password",
                  icon: Icons.lock_outline,
                  controller: passwordController,
                  isPassword: true,
                ),
                const SizedBox(height: 16),

                AppTextField(
                  label: "Confirm Password",
                  icon: Icons.lock_outline,
                  controller: confirmPasswordController,
                  isPassword: true,
                ),

                const SizedBox(height: 24),

                AppButton(text: "Create Account", onPressed: () {}),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Sign In"),
                    ),
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
