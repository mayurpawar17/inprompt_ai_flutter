import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inprompt_ai_flutter/core/widgets/custom_outlined_button.dart';

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
                    SvgPicture.asset('assets/inprompt_ai.svg', color: Colors.black, width: 200),
                    SizedBox(height: 20),
                    Text('Practice. Improve. Succeed.', style: TextStyle(fontSize: 20)),
                  ],
                ),
                CustomOutlinedButton(prefix: Image.asset('assets/google.png', height: 20), text: "Sign in with Google", onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
