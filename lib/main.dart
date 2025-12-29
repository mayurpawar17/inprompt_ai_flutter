import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'core/utils/app_routes.dart';
import 'features/auth/views/login_screen.dart';
import 'features/gemini/views/home_screen.dart';
import 'features/onboarding/bloc/splash_bloc.dart';
import 'features/onboarding/bloc/splash_event.dart';
import 'features/onboarding/views/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  log('main method');
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SplashBloc>(
          create: (_) => SplashBloc()..add(SplashStarted()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp(
      home: MaterialApp(
        initialRoute: AppRoutes.splash,
        title: 'InPrompt AI',
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.splash: (context) => SplashScreen(),
          AppRoutes.login: (context) => LoginScreen(),
          AppRoutes.home: (context) => HomeScreen(),
        },
      ),
    );
  }
}
