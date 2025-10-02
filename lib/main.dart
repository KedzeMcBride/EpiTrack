import 'package:flutter/material.dart';
import 'Pages/login_page.dart';
import 'Pages/registration_page.dart';

void main() {
  runApp(const MyApp()); // Remove const from here
}

class MyApp extends StatelessWidget {
  // Remove const constructor
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EpiTrack',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegistrationPage(),
      },
    );
  }
}




