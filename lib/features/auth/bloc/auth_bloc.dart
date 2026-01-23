import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repo/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<LoginRequested>(_onLogin);
    on<RegisterRequested>(_onRegister);
  }

  Future<void> _onLogin(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signIn(
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated(user));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Login failed"));
    }
  }

  Future<void> _onRegister(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signUp(
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated(user));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Signup failed"));
    }
  }
}
