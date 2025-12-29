import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../core/utils/app_routes.dart';

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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/inprompt_ai.svg',
                      color: Colors.black,
                      width: 200,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Practice. Improve. Succeed.',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                // Spacer(),
                ShadButton.outline(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.home,
                      (Route<dynamic> route) => false,
                    );
                  },
                  leading: Image.asset('assets/google.png'),
                  child: const Text('Sign in with Google'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
