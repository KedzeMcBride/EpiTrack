import 'package:flutter/material.dart';

class PatientsPage extends StatefulWidget {
  const PatientsPage({super.key});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EpiTrack',
          style: TextStyle(
            fontFamily: 'Billabong',
            fontSize: 32.0,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        backgroundColor: Colors.grey[300],
        foregroundColor: Colors.black,
        elevation: 0,
      ),
    );
  }
}