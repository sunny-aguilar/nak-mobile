import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nak_app/screens/home_screen.dart';
import 'package:nak_app/screens/login_screen.dart';
import 'package:nak_app/screens/register_screen.dart';

// this widget checks to see if a user is logged in. If logged in, they are
// redirected to the home page. If not logged in, redirected to the login page.
class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});
  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  // show login page initially
  bool showLoginPage = true;

  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

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
            // return const LoginScreen();
            if (showLoginPage) {
              print('Going to login screen: $showLoginPage');
              return LoginScreen(showRegisterPage: toggleScreens);
            }
            else {
              print('Going to registration screen: $showLoginPage');
              return RegisterScreen(showLoginScreen: toggleScreens);
            }
          }
        },
      ),
    );
  }
}