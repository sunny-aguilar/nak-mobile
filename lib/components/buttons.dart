import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nak_app/ui/theme.dart' as theme;

// red solid button
class RedButton extends StatelessWidget {
  final String text;
  final String url;
  const RedButton({super.key, required this.text, required this.url});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        padding: const EdgeInsets.all(20),
        backgroundColor: theme.redClr,
        foregroundColor: theme.whiteClr,
        side: const BorderSide(color: theme.redClr),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        textStyle: theme.TextThemes.button1(context),
      ),
      child: Text(text),
      onPressed: () {
        Future<void> launchUrlStart({required String url}) async {
          if (!await launchUrl(Uri.parse(url))) {
            throw 'Could not launch $url';
          }
        }
        launchUrlStart(url: url);
      },
    );
  }
}

// red outline button
class RedOutlineButton extends StatelessWidget {
  final String text;
  final String url;
  const RedOutlineButton({super.key, required this.text, required this.url});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        padding: const EdgeInsets.all(20),
        backgroundColor: theme.darkGreyClr,
        foregroundColor: theme.redClr,
        side: const BorderSide(color: theme.redClr, width: 2.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        textStyle: theme.TextThemes.button1(context),
      ),
      child: Text(text),
      onPressed: () {
        Future<void> launchUrlStart({required String url}) async {
          if (!await launchUrl(Uri.parse(url))) {
            throw 'Could not launch $url';
          }
        }
        launchUrlStart(url: url);
      },
    );
  }
}


class FormButtonLight extends StatelessWidget {
  final String text;
  final Function func;
  const FormButtonLight({super.key, required this.text, required this.func});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: const Size.fromHeight(60),
        padding: const EdgeInsets.all(8),
        backgroundColor: theme.blackClr,
        foregroundColor: theme.primaryClr,
        // side: const BorderSide(color: theme.darkGreyClr, width: 2.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        textStyle: theme.TextThemes.button1(context),
      ),
      child: Text(text),
      onPressed: () => func(),
    );
  }
}

class FormButtonDark extends StatelessWidget {
  final String text;
  const FormButtonDark({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: const Size.fromHeight(60),
        padding: const EdgeInsets.all(8),
        backgroundColor: theme.darkGreyClr,
        foregroundColor: theme.primaryClr,
        side: const BorderSide(color: theme.primaryClr, width: 2.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        textStyle: theme.TextThemes.button1(context),
      ),
      child: Text(text),
      onPressed: () {},
    );
  }
}

ButtonStyle buttonStyleLight(BuildContext context) {
  return TextButton.styleFrom(
    minimumSize: const Size.fromHeight(60),
    padding: const EdgeInsets.all(8),
    backgroundColor: theme.blackClr,
    foregroundColor: theme.primaryClr,
    // side: const BorderSide(color: theme.primaryClr, width: 2.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0),
    ),
    textStyle: theme.TextThemes.button1(context),
  );
}

ButtonStyle buttonStyleDark(BuildContext context) {
  return TextButton.styleFrom(
    minimumSize: const Size.fromHeight(60),
    padding: const EdgeInsets.all(8),
    backgroundColor: theme.darkGreyClr,
    foregroundColor: theme.primaryClr,
    side: const BorderSide(color: theme.primaryClr, width: 2.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0),
    ),
    textStyle: theme.TextThemes.button1(context),
  );
}

TextButton materialButton() {
  return TextButton(
    style: ButtonStyle(
      minimumSize: const MaterialStatePropertyAll<Size>(Size(400, 60),),
      foregroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 255, 255, 255)),
      backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 0, 0, 0)),
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.white.withOpacity(0.3);
          }
          return null; // Defer to the widget's default.
        },
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    ),
    onPressed: () {
      // store form field data into MAP
      // _formData['name'] = _nameCtl.text;
      // _formData['email'] = _emailCtl.text;
      // _formData['nature'] = _natureCtl.text;
      // _formData['urgency'] = _urgencyCtl.text;
      // _formData['date'] = _dateCtl.text;
      // _formData['location'] = _locationCtl.text;
      // _formData['desc'] = _descCtl.text;
      // _formData['uni'] = _uniCtl.text;
      // _formData['police'] = _policeCtl.text;
      // _formData['followUp'] = _followUpCtl.text;

      // // send email if validation passes
      // if (_formKey.currentState!.validate()) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text('Submitting report...')),
      //   );
      //   sendEmail(context, _formData);
      // }
    },
    child: const Text('Submit', style: TextStyle(fontSize: 20.0),)
  );
}


class SmallFormButtonLight extends StatelessWidget {
  final String text;
  final Function func;
  const SmallFormButtonLight({super.key, required this.text, required this.func});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: const Size.fromHeight(45),
        padding: const EdgeInsets.all(8),
        backgroundColor: theme.blackClr,
        foregroundColor: theme.primaryClr,
        // side: const BorderSide(color: theme.darkGreyClr, width: 2.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        textStyle: theme.TextThemes.button1(context),
      ),
      child: Text(text),
      onPressed: () => func(),
    );
  }
}

class SmallFormButtonDark extends StatelessWidget {
  final String text;
  final Function func;
  const SmallFormButtonDark({super.key, required this.text, required this.func});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: const Size.fromHeight(45),
        padding: const EdgeInsets.all(8),
        backgroundColor: theme.primaryClr,
        foregroundColor: theme.blackClr,
        // side: const BorderSide(color: theme.darkGreyClr, width: 2.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        textStyle: theme.TextThemes.button1(context),
      ),
      child: Text(text),
      onPressed: () => func(),
    );
  }
}

class SmallFilledButton extends StatelessWidget {
  const SmallFilledButton({
    super.key,
    required this.text,
    required Function func
  }) : tapMe = func;
  final String text;
  final Function tapMe;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {tapMe();},
      style: FilledButton.styleFrom(
        // minimumSize: const Size.fromHeight(45),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        backgroundColor: theme.primaryClr,
        foregroundColor: theme.blackClr,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      child: Text(text),
    );
  }
}

class CameraButton extends StatelessWidget {
  const CameraButton({
    super.key,
    required this.icon,
    required Function func
  }) : tapMe = func;
  final IconData icon;
  final Function tapMe;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {tapMe();},
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        minimumSize: const Size(90, 60),
        foregroundColor: theme.blackClr,
        backgroundColor: theme.primaryClr,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 50,),
        ],
      ),
    );
  }
}

class BlogOutlineCameraButton extends StatelessWidget {
  const BlogOutlineCameraButton({super.key, required this.text, required this.icon,});
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => {},
      style: OutlinedButton.styleFrom(
        fixedSize: const Size.fromHeight(70),
        side: BorderSide(width: 1, color: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        foregroundColor: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
      ),
      child: Icon(icon, size: 50),
    );
  }
}

class BlogFilledCameraButton extends StatelessWidget {
  const BlogFilledCameraButton({super.key, required this.text, required this.icon,});
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => {},
      style: FilledButton.styleFrom(
        fixedSize: const Size.fromHeight(70),
        foregroundColor: Get.isDarkMode ?theme.darkGreyClr : theme.primaryClr,
        backgroundColor: Get.isDarkMode ?theme.primaryClr : theme.darkGreyClr,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: Icon(icon, size: 50,),
    );
  }
}