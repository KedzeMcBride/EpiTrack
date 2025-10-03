import 'package:flutter/material.dart';
import 'Pages/login_page.dart';
import 'Pages/registration_page.dart';
import 'Pages/patients_page.dart';
import 'Pages/patient_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EpiTrack',
      debugShowCheckedModeBanner: false,
      initialRoute: '/patients',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegistrationPage(),
        '/patients': (context) => const PatientsPage(),
        '/patient_form': (context) => const PatientsForm(),
      },
    );
  }
}




