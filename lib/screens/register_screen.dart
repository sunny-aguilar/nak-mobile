import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/components/buttons.dart' as buttons;


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.showLoginScreen});
  final VoidCallback showLoginScreen;
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  // text controllers
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtr = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtr.dispose();
    super.dispose();
  }

  Future signUp() async {
    // sign up function

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // welcome section
            const Icon(Icons.phone_android, size: 100,),
            const SizedBox(height: 75,),
            Text('Hello There,', style: theme.TextThemes.loginTitle(context)),
            const SizedBox(height: 10,),
            Text('Register below with your details.', textAlign: TextAlign.center, style: theme.TextThemes.loginHeadline(context)),
            const SizedBox(height: 50,),

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
                controller: _passwordCtr,
                obscureText: true,
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(height: 20,),

            // sign in button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextButton(
                style: Get.isDarkMode ? buttons.buttonStyleDark(context) : buttons.buttonStyleLight(context),
                child: const Text('Register'),
                onPressed: () {
                  signUp();
                },
              ),
            ),
            const SizedBox(height: 25,),

            // not a member? register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('I\'m a member! ', style: theme.TextThemes.loginBody(context),),
                const SizedBox(width: 6,),
                // Add a gesture detector to text to get to registration screen
                GestureDetector(
                  onTap: widget.showLoginScreen,
                  child: Text('Login now', style: theme.TextThemes.loginRegisterBody(context),),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}