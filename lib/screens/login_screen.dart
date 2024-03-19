import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nak_app/screens/forgot_pw_screen.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/components/buttons.dart' as buttons;

class LoginScreen extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginScreen({super.key, required this.showRegisterPage});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKeyLogin = GlobalKey<FormState>();

  // text controllers
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtr = TextEditingController();

  // sign in method
  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailCtrl.text.trim(),
        password: _passwordCtr.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Unable to authenticate password.')),
          );
        }
        else if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No user found for that email.')),
          );
        }
        else {
          print(e);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('The supplied credential is invalid.')),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKeyLogin,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // welcome section
              const Icon(Icons.phone_android, size: 100,),
              const SizedBox(height: 75,),
              Text('Welcome, Brother', textAlign: TextAlign.center, style: theme.TextThemes.loginTitle(context),),
              const SizedBox(height: 10,),
              Text('Men of Mind...Men of Culture...Men of Pride...', textAlign: TextAlign.center, style: theme.TextThemes.loginHeadline(context)),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email.';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password.';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 2,),

              // forgot password link
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return const ForgotPwScreen();
                        }));
                      },
                      child: Text('Forgot Password?', style: theme.TextThemes.linkBody(context),),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),

              // sign in button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextButton(
                  style: Get.isDarkMode ? buttons.buttonStyleDark(context) : buttons.buttonStyleLight(context),
                  child: const Text('Sign In'),
                  onPressed: () {
                    if (_formKeyLogin.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 1500),
                          content: Text('Authenticating user...')
                        ),
                      );
                      signIn();
                    }
                  },
                ),
              ),
              const SizedBox(height: 25,),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Not a member?', style: theme.TextThemes.loginBody(context),),
                  const SizedBox(width: 6,),
                  // Add a gesture detector to text to get to registration screen
                  GestureDetector(
                    onTap: widget.showRegisterPage,
                    child: Text('Register now', style: theme.TextThemes.linkBody(context),),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}