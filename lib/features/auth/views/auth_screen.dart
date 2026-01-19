import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../data/repo/auth_repository.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(AuthRepository()),
      child: Scaffold(
        body: Center(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const CircularProgressIndicator();
              }

              if (state is AuthSuccess) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Welcome ${state.user.displayName}"),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(SignOutRequested());
                      },
                      child: const Text("Sign Out"),
                    ),
                  ],
                );
              }

              return ElevatedButton.icon(
                icon: const Icon(Icons.login),
                label: const Text("Sign in with Google"),
                onPressed: () {
                  context.read<AuthBloc>().add(GoogleSignInRequested());
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
