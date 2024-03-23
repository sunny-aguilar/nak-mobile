import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:email_validator/email_validator.dart';
import 'package:nak_app/components/buttons.dart' as buttons;


class ForgotPwScreen extends StatefulWidget {
  const ForgotPwScreen({super.key});
  @override
  State<ForgotPwScreen> createState() => _ForgotPwScreenState();
}

class _ForgotPwScreenState extends State<ForgotPwScreen> {
  final _formKeyResetPw = GlobalKey<FormState>();

  // text controllers
  final TextEditingController _emailCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  // password reset
  Future passwordReset() async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailCtrl.text.trim());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 5),
            content: Text('If a matching account was found, we will send a password reset to ${_emailCtrl.text.trim()}.')
          ),
        );
        Timer(
          const Duration(seconds: 6), ()=> Navigator.pop(context)
        );
      }
    } on FirebaseAuthException catch (e) {
      print('Reset error: $e');
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          }
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKeyResetPw,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              // info text
              const Icon(Icons.lock_reset, size: 150),
              const SizedBox(height: 75,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Text('Enter your email and we will send you a password reset link.', textAlign: TextAlign.center,),
              ),
              const SizedBox(height: 20,),

              // email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Email',
                      helperText: '*required'
                    ),
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      bool isValid = EmailValidator.validate(value!);
                      if (!isValid) {
                        return 'Enter a valid email.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20,),

                // reset button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextButton(
                    style: Get.isDarkMode ? buttons.buttonStyleDark(context) : buttons.buttonStyleLight(context),
                    child: const Text('Reset'),
                    onPressed: () {
                      if (_formKeyResetPw.currentState!.validate()) {
                        // process data if form fields pass validation
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 1500),
                            content: Text('Processing request...')
                          ),
                        );
                        passwordReset();
                      }
                    },
                  ),
                ),
                const SizedBox(height: 80,),

            ]
          ),
        ),
      ),
    );
  }
}