import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:email_validator/email_validator.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/components/buttons.dart' as buttons;


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.showLoginScreen});
  final VoidCallback showLoginScreen;
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKeyRegistration = GlobalKey<FormState>();

  // text controllers
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _confirmPwCtrl = TextEditingController();
  final TextEditingController _firstNamePwCtrl = TextEditingController();
  final TextEditingController _lastNamePwCtrl = TextEditingController();
  final TextEditingController _chapterCtrl = TextEditingController();
  final TextEditingController _lineNumberCtrl = TextEditingController();
  final TextEditingController _statusCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPwCtrl.dispose();
    super.dispose();
  }

  // create user
  Future signUp() async {
    if (passwordConfirmed()) {
      // sign up function
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailCtrl.text.trim(),
          password: _passwordCtrl.text.trim(),
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(seconds: 5),
              content: Text('Account successfully created.')
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          // print('The account already exists for that email.');
          if (mounted) {
            _dialogBuilder(context);
          }
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            'The account already exists for that email.',
            textAlign: TextAlign.center,
            style: theme.TextThemes.loginHeadline(context),
          ),
          actions: <Widget>[
            Get.isDarkMode ?
            buttons.SmallFormButtonDark(text: 'Dismiss', func: () {return Navigator.of(context).pop(); }) :
            buttons.SmallFormButtonLight(text: 'Dismiss', func: () {return Navigator.of(context).pop(); },),
          ],
        );
      }
    );
  }

  // makes sure passwords match each other
  bool passwordConfirmed() {
    if (_passwordCtrl.text.trim() == _confirmPwCtrl.text.trim()) {
      return true;
    }
    return false;
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
          key: _formKeyRegistration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // welcome section
              const Icon(Icons.person_add, size: 100,),
              const SizedBox(height: 75,),
              Text('Registration', textAlign: TextAlign.center, style: theme.TextThemes.loginTitle(context),),
              const SizedBox(height: 10,),
              Text('Sign up below with your details.', textAlign: TextAlign.center, style: theme.TextThemes.loginHeadline(context)),
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
                    bool isValid = EmailValidator.validate(value!);
                    if (!isValid) {
                      return 'Enter a valid email.';
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
                  controller: _passwordCtrl,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password with at least 8 characters.';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters.';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20,),

              // confirm password text field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.fingerprint),
                    labelText: 'Confirm Password',
                    helperText: '*required'
                  ),
                  controller: _confirmPwCtrl,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password with at least 8 characters.';
                    }
                    else if (value != _passwordCtrl.text.trim()) {
                      return 'Make sure passwords match.';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20,),

              // sign in button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextButton(
                  style: Get.isDarkMode ? buttons.buttonStyleDark(context) : buttons.buttonStyleLight(context),
                  child: const Text('Sign Up'),
                  onPressed: () {
                    if (_formKeyRegistration.currentState!.validate()) {
                      // process data if form is valid
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 1000),
                          content: Text('Processing request...')
                        ),
                      );
                      signUp();
                    }
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
                    child: Text('Login now', style: theme.TextThemes.linkBody(context),),
                  ),
                ],
              ),
              const SizedBox(height: 45,),

            ],
          ),
        ),
      ),
    );
  }
}