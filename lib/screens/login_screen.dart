import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/components/buttons.dart' as buttons;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: <Widget>[
          // welcome text
          const SizedBox(height: 20,),
          Text('Hello Again!', style: theme.TextThemes.headlineLarge(context)),
          const SizedBox(height: 10,),
          Text('Men of Mind...Men of Culture...Men of Pride...', textAlign: TextAlign.center, style: theme.TextThemes.headlineMed(context)),
          const SizedBox(height: 40,),

          // email textfield
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: 'Email',
                helperText: '*required'
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          const SizedBox(height: 20,),

          // password textfield
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.fingerprint),
                labelText: 'Password',
                helperText: '*required'
              ),
              obscureText: true,
              keyboardType: TextInputType.name,
            ),
          ),
          const SizedBox(height: 20,),

          // sign in button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextButton(
              style: Get.isDarkMode ? buttons.buttonStyleDark(context) : buttons.buttonStyleLight(context),
              child: const Text('Submit'),
              onPressed: () {},
            ),
          )

          // not a member? register now
        ],
      ),
    );
  }
}