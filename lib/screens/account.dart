import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nak_app/db/db_ops.dart' as db;
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/components/buttons.dart' as buttons;


class MyAccount extends StatefulWidget {
  const MyAccount({super.key});
  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.lightGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   width: double.infinity,
            //   child: Text(
            //     'Account Settings',
            //     style: theme.TextThemes.drawerMenuNT(context),
            //     textAlign: TextAlign.center,
            //   )
            // ),
            const SizedBox(height: 25,),
            Text('Delete Your Account', style: theme.TextThemes.headlineMedLarge(context),),
            const SizedBox(height: 25,),
            Text('Deleting your account will do the following:', style: theme.TextThemes.bodyLarge(context),),
            const SizedBox(height: 25,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              child: Row(
                children: <Widget>[
                  const FaIcon(FontAwesomeIcons.circleXmark, size: 20.0, color: theme.pinkClr,),
                  Text(' Log you out of your device', style: theme.TextThemes.bodyMedLarge(context),),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              child: Row(
                children: <Widget>[
                  const FaIcon(FontAwesomeIcons.circleXmark, size: 20.0, color: theme.pinkClr,),
                  Text(' Remove all of your account information', style: theme.TextThemes.bodyMedLarge(context),),
                ],
              ),
            ),
            const SizedBox(height: 45,),
            TextButton(
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Are you sure?'),
                      content: const Text('You will lose all of your data by deleting your account. This action cannot be undone.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            // have the user enter their password again, if needed

                            // add a 'isactive' flag to Firebase to prevent data from showing
                            db.DeactivateUserData().deactivate();

                            // delete the user's account & sign out ()
                            db.DeleteAuthUser().deleteSignout();

                            // navigate back to the Auth screen
                            Navigator.pushReplacementNamed(context, '/auth');
                          },
                          style: buttons.buttonStyleRed(context),
                          child: const Text('Delete'),
                        ),
                        const SizedBox(height: 10.0,),
                        TextButton(
                          onPressed: () { Navigator.pop(context, 'cancel'); },
                          style: buttons.buttonStyleLightTheme(context),
                          child: const Text('Cancel'),
                        ),
                      ],
                    );
                  }
                );
              },
              style: buttons.buttonStyleRed(context),
              child: const Text('Delete Account'),
            )
          ],
        ),
      ),
    );
  }
}