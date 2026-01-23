import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inprompt_ai_flutter/firebase_options.dart';

import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/data/repo/auth_repository.dart';
import 'features/onboarding/bloc/splash_bloc.dart';
import 'features/onboarding/bloc/splash_event.dart';
import 'features/onboarding/views/splash_screen.dart';

void main() async {
  log('main method');
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SplashBloc>(
          create: (_) => SplashBloc()..add(SplashStarted()),
        ),
        BlocProvider(create: (_) => AuthBloc(AuthRepository())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InPrompt AI',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
