import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              // logo
              Image.asset(
                'lib/images/logo.png',
                height: 150, // Adjust height as needed
                width: 150,  // Adjust width as needed
              ),
              const SizedBox(height: 50),

              // welcome back
              Text(
                "Welcome Back You've been Missed",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),

              // user text-field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: 'Username',
                  ),
                ),
              ),

              // password text-field

              // forgot password

              // sign in button

              // or continue with

              // google or apple

              // register option
            ],
          ),
        ),
      ),
    );
  }
}