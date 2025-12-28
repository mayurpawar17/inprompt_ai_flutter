import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inprompt_ai_flutter/features/onboarding/bloc/splash_event.dart';
import 'package:inprompt_ai_flutter/features/onboarding/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashStarted>(_onSplashStarted);
  }

  Future<void> _onSplashStarted(
    SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    //fake delay
    await Future.delayed(Duration(seconds: 1));
    // FAST checks only (local)
    // final isLoggedIn = await authRepo.isLoggedIn();
    // final isFirstTime = await storage.isFirstTime();
    final isLoggedIn = true;
    final isFirstTime = false;

    if (isFirstTime) {
      emit(SplashNavigate('/onboarding'));
    } else if (isLoggedIn) {
      emit(SplashNavigate('/home'));
    } else {
      emit(SplashNavigate('/login'));
    }
  }
}
