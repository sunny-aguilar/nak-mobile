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
  final username = FirebaseAuth.instance.currentUser?.displayName;
  // Controllers
  final TextEditingController _nameCtl = TextEditingController();

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
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10,),
              Text('Update Your Profile', style: theme.TextThemes.headlineMed(context)),
              const SizedBox(height: 10,),
              Text('You can only update your display name at this time. Chapter and line numbers are permanent.', textAlign: TextAlign.center, style: theme.TextThemes.bodyMedLarge(context)),
              const SizedBox(height: 10,),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person_2_outlined),
                  labelText: 'Update Your Name*',
                  helperText: '*Current name: $username',
                ),
                controller: _nameCtl,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 10,),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    db_profile.UpdateUsers().updateDisplayName(_nameCtl.text.trim());
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: theme.primaryClr,
                    backgroundColor: theme.redClr,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)
                    ),
                  ),
                  child: Text('Update'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}