import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/db/db_user_profiles.dart' as db_profile;

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  // get username from profile
  final username = FirebaseAuth.instance.currentUser?.displayName;
  // form key
  final _profileFormKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _firstnameCtl = TextEditingController();
  final TextEditingController _lastnameCtl = TextEditingController();
  final TextEditingController _positionCtl = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    _firstnameCtl.dispose();
    _lastnameCtl.dispose();
    _positionCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.redClr,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _profileFormKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10,),
                Text('Update Your Profile', style: theme.TextThemes.headlineMed(context)),
                const SizedBox(height: 10,),
                Text('You can only update your display name at this time. Chapter and line numbers are permanent.', textAlign: TextAlign.center, style: theme.TextThemes.bodyMedLarge(context)),
                const SizedBox(height: 20,),
                Text('Current Name: $username'),
                const SizedBox(height: 10,),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_2_outlined),
                    labelText: 'Update Your First Name*',
                    helperText: '*Required',
                  ),
                  controller: _firstnameCtl,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_2_outlined),
                    labelText: 'Update Your Last Name*',
                    helperText: '*Required',
                  ),
                  controller: _lastnameCtl,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your lastname';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_2_outlined),
                    labelText: 'Update Your Chapter/NEB Position*',
                    helperText: '*Required',
                  ),
                  controller: _positionCtl,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your chapter/NEB position';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      if (_profileFormKey.currentState!.validate()) {
                        db_profile.UpdateUsers().updateUser(
                          _firstnameCtl.text.trim(),
                          _lastnameCtl.text.trim(),
                          _positionCtl.text.trim());
                        Navigator.pop(context);
                      }
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: theme.primaryClr,
                      backgroundColor: theme.redClr,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)
                      ),
                    ),
                    child: const Text('Update'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}