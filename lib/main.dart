import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'core/routes/app_routes.dart';
import 'pages/splash/splash_page.dart';
import 'pages/auth/login_page.dart';
import 'pages/auth/signup_page.dart';
import 'pages/home/home_page.dart';
import 'pages/registration/registration_page.dart';
import 'pages/info/info_page.dart';
import 'pages/manualPlaning/manualPlanning.dart';
import 'pages/veiwPlanning/viewPlanning.dart';
import 'pages/marketList/marketList.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MealPlanningApp());
}

class MealPlanningApp extends StatelessWidget {
  const MealPlanningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (_) => const SplashPage(),
        AppRoutes.login: (_) => const LoginPage(),
        AppRoutes.signup: (_) => const SignupPage(),
        AppRoutes.home: (_) => const HomePage(),
        AppRoutes.registration: (_) => const RegistrationPage(),
        AppRoutes.info: (_) => const InfoPage(),
        AppRoutes.manualPlanning: (context) => ManualPlanningPage(),
        AppRoutes.viewPlanning: (context) => ViewPlanningPage(),
        AppRoutes.marketList: (_) =>  MarketListPage(),
      },
    );
  }
}