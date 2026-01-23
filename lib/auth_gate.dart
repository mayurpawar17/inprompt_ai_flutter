import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inprompt_ai_flutter/features/auth/views/sign_in_screen.dart';
import 'package:inprompt_ai_flutter/features/gemini/views/home_screen.dart';

import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/bloc/auth_state.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        log(state.toString());
        if (state is AuthLoading || state is AuthInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is AuthAuthenticated) {
          return const HomeScreen();
        }

        return SignInScreen();
      },
    );
  }
}
