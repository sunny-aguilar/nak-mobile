import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nak_app/screens/home_screen.dart';
import 'package:nak_app/screens/login_screen.dart';
import 'package:nak_app/screens/register_screen.dart';
import 'package:nak_app/screens/email_verification_screen.dart';
import 'package:nak_app/ui/theme.dart' as theme;

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

  Center _circularProgress() {
    return const Center(
      child: SizedBox(
        height: 75, width: 75,
        child: CircularProgressIndicator(
          strokeWidth: 5, color: theme.redClr, backgroundColor: theme.lightGrey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user == null) {
              if (showLoginPage) {
                return LoginScreen(showRegisterPage: toggleScreens);
              }
              else {
                return RegisterScreen(showLoginScreen: toggleScreens);
              }
            }
            else {
              if (user.emailVerified) {
                return const HomeScreen();
              }
              else {
                return const EmailVerificationScreen();
              }
            }
          }
          return _circularProgress();
        },
      ),
    );
  }
}