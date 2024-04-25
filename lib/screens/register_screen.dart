import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nak_app/services/create_id_number.dart' as id;
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
  final TextEditingController _firstNameCtrl = TextEditingController();
  final TextEditingController _lastNameCtrl = TextEditingController();
  final TextEditingController _chapterCtrl = TextEditingController();
  final TextEditingController _class = TextEditingController();
  final TextEditingController _lineNumberCtrl = TextEditingController();
  final TextEditingController _statusCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _confirmPwCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPwCtrl.dispose();
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _chapterCtrl.dispose();
    _lineNumberCtrl.dispose();
    _statusCtrl.dispose();
    super.dispose();
  }

  // create user
  Future signUp() async {
    if (passwordConfirmed()) {
      try {
        // create user
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailCtrl.text.trim(),
          password: _passwordCtrl.text.trim(),
        );

        // send confirmation email to user
        // FirebaseAuth.instance
        //   .authStateChanges()
        //   .listen((User? user) async {
        //     if (user != null) {
        //       final user = FirebaseAuth.instance.currentUser!;
        //       await user.sendEmailVerification();
        //     }
        //   });

        // show message indicating account creation status
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(seconds: 5),
              content: Text('Account successfully created.')
            ),
          );
        }

        // add users details to user profile
        FirebaseAuth.instance
          .authStateChanges()
          .listen((User? user) async {
            if (user != null) {
              final user = FirebaseAuth.instance.currentUser!;
              await user.updateDisplayName('${_firstNameCtrl.text.trim()} ${_lastNameCtrl.text.trim()}');
            }
          });

        // add user details to firebase
        addUserDetails(
          _firstNameCtrl.text.trim(),
          _lastNameCtrl.text.trim(),
          _chapterCtrl.text.trim(),
          _class.text.trim(),
          _lineNumberCtrl.text.trim(),
          _emailCtrl.text.trim(),
          _statusCtrl.text.trim(),
        );

      // alert: account already exists
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

  Future addUserDetails(String firstName, String lastName, String chapter, String className, String lineNumber, String email, String status) async {
    // to write to DB, you must change rules
    // to this: allow read, write: if request.auth != null;
    // from this (this rule locks Firestore): allow read, write: if false;

    // Security Rules:
    // lock Firestore: allow read, write: if request.auth != null;
    // open Firesetore: allow read, write: if request.auth != null;

    // get user UID
    final FirebaseAuth auth = FirebaseAuth.instance;
    final userUID = auth.currentUser!.uid;

    final String nakID = id.GenerateID(chapter: chapter, className: className, lineNumber: lineNumber).generateID();

    final db = FirebaseFirestore.instance;

    // doc().set() allows to specify a document name
    db.collection('users').doc(userUID).set({
      'uid': userUID,
      // 'nakID': '0000 0000 0000 0000',
      'nakID': nakID,
      'firstName': firstName,
      'lastName': lastName,
      'chapter': chapter,
      'lineNumber': lineNumber,
      'email': email,
      'status': status,
      'selfie': '',
      // default settings
      'isAdmin': [],
      'isNEB': false,
      'rights': {'chat':false, 'blog':false,},
    });

    // add() auto-creates a document name
    // db.collection('users').add({
    //   'firstName': firstName,
    //   'lastName': lastName,
    //   'chapter': chapter,
    //   'lineNumber': lineNumber,
    //   'email': email,
    //   'status': status,
    // });
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
          key: _formKeyRegistration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // welcome section
              const Icon(Icons.rocket_launch, size: 100,),
              const SizedBox(height: 75,),
              Text('Registration', textAlign: TextAlign.center, style: theme.TextThemes.loginTitle(context),),
              const SizedBox(height: 10,),
              Text('Register with your @nakinc.org email', textAlign: TextAlign.center, style: theme.TextThemes.loginHeadline(context)),
              TextButton(
                onPressed: () async {
                Future<void> launchUrlStart({required String url}) async {
                  if (!await launchUrl(Uri.parse(url))) {
                    throw 'Could not launch $url';
                  }
                }
                launchUrlStart(url: 'https://naknet.org/newnakincaddress/');
              },
                child: Text('Request a @nakinc.org email',
                style: theme.TextThemes.linkBody(context), textAlign: TextAlign.center,),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text('Why create an account? An account is needed to allow us to destinguish between users and to customize the app experience based on the role of each user. Members of the National Executive Board will be able to publish blogs. Undergrads will be able to access fraternity resources quickly and on the go. Our App Privacy Policy can be found at the bottom.', style: theme.TextThemes.loginDescription(context), textAlign: TextAlign.center,),
              ),
              const SizedBox(height: 30,),

              // first name textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
                    labelText: 'First Name',
                    helperText: '*required'
                  ),
                  controller: _firstNameCtrl,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name.';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20,),

              // last name textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
                    labelText: 'Last Name',
                    helperText: '*required'
                  ),
                  controller: _lastNameCtrl,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name.';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20,),

              // chapter dropdown field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: DropdownButtonFormField(
                  hint: Text(
                    'Select a chapter',
                    style: TextStyle(
                          color: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  onChanged: (val) {
                    _chapterCtrl.text = val!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a chapter';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.house_outlined),
                    labelText: 'Your chapter',
                    helperText: '*required',
                  ),
                  dropdownColor: Get.isDarkMode ? theme.darkGreyClr : theme.primaryClr,
                  items: <String>[
                    'Founding', 'Alpha', 'Beta', 'Gamma', 'Delta', 'Epsilon', 'Zeta',
                    'Eta', 'Theta', 'Iota', 'Kappa', 'Lambda', 'Mu', 'Nu', 'Xi',
                    'Omicron', 'Pi', 'Rho', 'Sigma', 'Tau', 'Upsilon', 'Phi', 'Chi',
                    'Psi', 'Alpha Alpha', 'Alpha Beta', 'Alpha Gamma', 'Alpha Delta',
                  ]
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20,),

              // class dropdown field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: DropdownButtonFormField(
                  hint: Text(
                    'Select a class',
                    style: TextStyle(
                          color: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  onChanged: (val) {
                    _class.text = val!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a class';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.house_outlined),
                    labelText: 'Your class',
                    helperText: '*required',
                  ),
                  dropdownColor: Get.isDarkMode ? theme.darkGreyClr : theme.primaryClr,
                  items: <String>[
                    'Founding','Alpha','Beta','Gamma','Delta','Epsilon','Zeta','Eta','Theta','Iota','Kappa','Lambda','Mu','Nu','Xi','Omicron','Pi','Rho','Sigma','Tau','Upsilon','Phi','Chi','Psi','Alpha Alpha','Alpha Beta','Alpha Gamma','Alpha Delta','Alpha Epsilon','Alpha Zeta','Alpha Eta','Alpha Theta','Alpha Iota','Alpha Kappa','Alpha Lambda','Alpha Mu','Alpha Nu','Alpha Xi','Alpha Omicon','Alpha Pi','Alpha Rho','Alpha Sigma','Alpha Tau','Alpha Upsilon','Alpha Phi','Alpha Chi','Alpha Psi','Beta Alpha','Beta Beta','Beta Gamma','Beta Delta','Beta Epsilon','Beta Zeta','Beta Eta','Beta Theta','Beta Iota','Beta Kappa','Beta Lambda','Beta Mu','Beta Nu','Beta Xi','Beta Omicron','Beta Pi','Beta Rho','Beta Sigma','Beta Tau','Beta Upsilon','Beta Phi','Beta Chi','Beta Psi',
                  ]
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20,),

              // line number textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.numbers),
                    labelText: 'Line Number',
                    helperText: '*required'
                  ),
                  controller: _lineNumberCtrl,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your line number.';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20,),

              // status textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: DropdownButtonFormField(
                  hint: Text(
                    'Graduate status',
                    style: TextStyle(
                          color: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  onChanged: (val) {
                    _statusCtrl.text = val!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your graduate status';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.school_outlined),
                    labelText: 'Your status',
                    helperText: '*required',
                  ),
                  dropdownColor: Get.isDarkMode ? theme.darkGreyClr : theme.primaryClr,
                  items: <String>[
                    'Undergrad', 'Alumni', 'NA',
                  ]
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              // email textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    labelText: 'Email',
                    helperText: '*required'
                  ),
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    final bool emailValid = RegExp(r'^[a-zA-Z0-9.a-zA-Z0-9-_]+@nakinc\.org$').hasMatch(value!);
                    if (!emailValid) {
                      return 'Enter a valid @nakinc.org email.';
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

              // already a member? sign in now
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
              const SizedBox(height: 10.0,),
              TextButton(
                onPressed: () async {
                Future<void> launchUrlStart({required String url}) async {
                  if (!await launchUrl(Uri.parse(url))) {
                    throw 'Could not launch $url';
                  }
                }
                launchUrlStart(url: 'https://www.naknet.org/nak-app-privacy-policy/');
              },
                child: Text('App Privacy Policy',
                style: theme.TextThemes.linkBody(context), textAlign: TextAlign.center,),
              ),
              const SizedBox(height: 45,),

            ],
          ),
        ),
      ),
    );
  }
}