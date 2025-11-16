import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tasky/firebase_options.dart';
import 'package:tasky/views/pages/home_page.dart';
import 'package:tasky/views/pages/login_page.dart';
import 'package:tasky/views/pages/onboarding_page.dart';
import 'package:tasky/views/pages/register_page.dart';
// import 'package:tasky/views/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: {
        '/onboarding': (context) => const OnboardingPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
      },
      initialRoute: '/onboarding',
    );
  }
}