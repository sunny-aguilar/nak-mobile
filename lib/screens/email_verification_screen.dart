import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/components/buttons.dart' as buttons;

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});
  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  late Timer _timer;

  void setTimerForRedirect() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      print(timer.tick);
      FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user!.emailVerified) {
        timer.cancel();
        Navigator.of(context).pushNamed('/auth');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setTimerForRedirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 100,),
              const Icon(Icons.drafts, size: 75,),
              const SizedBox(height: 40,),
              Text('Verify your email address', style: theme.TextThemes.headlineMedLarge(context),),
              const SizedBox(height: 25,),
              Text('We have just sent you an email verification link. Please check your email and click on that link to verify your email address.', textAlign: TextAlign.center, style: theme.TextThemes.bodyLarge(context),),
              const SizedBox(height: 20,),
              Text('If you are not auto redirected after verification, click on the Continue button.', textAlign: TextAlign.center, style: theme.TextThemes.bodyLarge(context),),
              const SizedBox(height: 20,),
              TextButton(
                onPressed: () {
                  setTimerForRedirect();
                },
                style: Get.isDarkMode ? buttons.buttonStyleDark(context) : buttons.buttonStyleLight(context),
                child: Text('Continue', style: theme.TextThemes.bodyLarge(context),),
              ),
              const SizedBox(height: 20,),
              Text('Resend E-Mail Link'),
              const SizedBox(height: 20,),
              Text('<- back to login'),
            ],
          ),
        ),
      ),
    );
  }
}