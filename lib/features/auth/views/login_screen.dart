import 'package:flutter/material.dart';
import 'package:inprompt_ai_flutter/features/auth/widgets/google_sign_in_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: AppColors.primaryBgColor,
      // backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(child:GoogleSignInButton(onTap: (){})),
        ),
      ),
    );
  }
}
