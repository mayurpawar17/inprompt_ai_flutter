import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inprompt_ai_flutter/features/auth/bloc/auth_state.dart';
import 'package:inprompt_ai_flutter/features/auth/views/sign_up_screen.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLoading) {
                showDialog(
                  context: context,
                  builder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                );
              }

              if (state is AuthAuthenticated) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SignUpScreen()),
                );
              }

              if (state is AuthError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),

                  Text(
                    "Welcome Back 👋",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Sign in to continue",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  const SizedBox(height: 32),

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

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("Forgot Password?"),
                    ),
                  ),

                  const SizedBox(height: 16),

                  AppButton(
                    text: "Sign In",
                    onPressed: () {
                      context.read<AuthBloc>().add(
                        LoginRequested(
                          emailController.text,
                          passwordController.text,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don’t have an account? "),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => SignUpScreen()),
                          );
                        },
                        child: const Text("Sign Up"),
                      ),
                    ],
                  ),

                  const Spacer(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
