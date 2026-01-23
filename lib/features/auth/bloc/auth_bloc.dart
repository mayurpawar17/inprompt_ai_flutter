import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repo/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  StreamSubscription<User?>? _userSub;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoginRequested>(_onLogin);
    on<RegisterRequested>(_onRegister);
    on<LogoutRequested>(_onLogout);

    // 👇 INTERNAL EVENTS (from Firebase stream)
    on<_InternalAuthenticated>((event, emit) {
      emit(AuthAuthenticated(event.user));
    });

    on<_InternalUnauthenticated>((event, emit) {
      emit(AuthUnauthenticated());
    });
  }
  void _onAppStarted(AppStarted event, Emitter<AuthState> emit) {
    emit(AuthLoading());

    _userSub?.cancel();
    _userSub = authRepository.userChanges.listen((user) {
      if (user != null) {
        add(_InternalAuthenticated(user));
      } else {
        add(_InternalUnauthenticated());
      }
    });
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

  Future<void> _onLogout(LogoutRequested event, Emitter<AuthState> emit) async {
    await authRepository.signOut();
    emit(AuthUnauthenticated());
  }

  @override
  Future<void> close() {
    _userSub?.cancel();
    return super.close();
  }
}

// ❌ DO NOT put in auth_event.dart
// ✅ Put ONLY in auth_bloc.dart

class _InternalAuthenticated extends AuthEvent {
  final User user;
  _InternalAuthenticated(this.user);
}

class _InternalUnauthenticated extends AuthEvent {}
