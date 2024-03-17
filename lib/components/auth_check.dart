import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nak_app/screens/home_screen.dart';
import 'package:nak_app/screens/login_screen.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          else {
            return const LoginScreen();
            // Navigator.pushNamed(context, '/home');
            // return Placeholder();
          }
        },
      ),
    );
  }
}